# Copyright (c) HashiCorp, Inc.

locals {
  dindVolumeMounts = var.dind ? [{
    mountPath = "/var/run/docker.sock"
    name      = "dockersock"
    readOnly  = false
  }] : []
  dindVolumes = var.dind ? [
    {
      name = "dockersock"

      hostPath = {
        path = "/var/run/docker.sock"
      }
  }] : []
  network_name    = var.create_network ? google_compute_network.tfc-agent-network[0].self_link : var.network_name
  subnet_name     = var.create_network ? google_compute_subnetwork.tfc-agent-subnetwork[0].self_link : var.subnet_name
  service_account = var.service_account == "" ? google_service_account.tfc_agent_service_account[0].email : var.service_account
  # location   = var.regional ? var.region : var.zones[0]
}

/*****************************************
  Optional TFC Agent Networking
 *****************************************/
resource "google_compute_network" "tfc-agent-network" {
  count                   = var.create_network ? 1 : 0
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tfc-agent-subnetwork" {
  count         = var.create_network ? 1 : 0
  project       = var.project_id
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.region
  network       = google_compute_network.tfc-agent-network[0].name
}

resource "google_compute_router" "default" {
  count   = var.create_network ? 1 : 0
  name    = "${var.network_name}-router"
  network = google_compute_network.tfc-agent-network[0].self_link
  region  = var.region
  project = var.project_id
}

resource "google_compute_router_nat" "nat" {
  count                              = var.create_network ? 1 : 0
  project                            = var.project_id
  name                               = "${var.network_name}-nat"
  router                             = google_compute_router.default[0].name
  region                             = google_compute_router.default[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

/*****************************************
  IAM Bindings GCE SVC
 *****************************************/

resource "google_service_account" "tfc_agent_service_account" {
  count        = var.service_account == "" ? 1 : 0
  project      = var.project_id
  account_id   = "tfc-agent-service-account"
  display_name = "Terrform Agent GCE Service Account"
}

# allow GCE to pull images from GCR
resource "google_project_iam_binding" "gce" {
  count   = var.service_account == "" ? 1 : 0
  project = var.project_id
  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${local.service_account}",
  ]
}

/*****************************************
  TFC Agent GCE Instance Template
 *****************************************/
locals {
  instance_name = format("%s-%s", var.instance_name, substr(md5(module.gce-container.container.image), 0, 8))
}

module "gce-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 3.0"
  container = {
    image = var.image
    env = [
      {
        name  = "TFC_AGENT_TOKEN"
        value = var.tfc_agent_token
      },
      {
        name  = "TFC_AGENT_SINGLE"
        value = var.tfc_agent_single
      }
    ]

    # Declare volumes to be mounted
    # This is similar to how Docker volumes are mounted
    volumeMounts = concat([
      {
        mountPath = "/cache"
        name      = "tempfs-0"
        readOnly  = false
      }
    ], local.dindVolumeMounts)
  }

  # Declare the volumes
  volumes = concat([
    {
      name = "tempfs-0"

      emptyDir = {
        medium = "Memory"
      }
    }
  ], local.dindVolumes)

  restart_policy = var.restart_policy
}

module "mig_template" {
  source             = "terraform-google-modules/vm/google//modules/instance_template"
  version            = "~> 7.0"
  project_id         = var.project_id
  region             = var.region
  network            = local.network_name
  subnetwork         = local.subnet_name
  subnetwork_project = var.subnetwork_project != "" ? var.subnetwork_project : var.project_id
  service_account = {
    email = local.service_account
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
  disk_size_gb         = 100
  disk_type            = "pd-ssd"
  auto_delete          = true
  name_prefix          = "tfc-agent"
  source_image_family  = "cos-stable"
  source_image_project = "cos-cloud"
  startup_script       = var.startup_script
  source_image         = reverse(split("/", module.gce-container.source_image))[0]
  metadata = merge(var.additional_metadata, {
    google-logging-enabled      = "true"
    "gce-container-declaration" = module.gce-container.metadata_value
  })
  tags = [
    "tfc-agent-vm"
  ]
  labels = {
    container-vm = module.gce-container.vm_container_label
  }
}
/*****************************************
  TFC Agent MIG
 *****************************************/
module "mig" {
  source             = "terraform-google-modules/vm/google//modules/mig"
  version            = "~> 7.0"
  project_id         = var.project_id
  subnetwork_project = var.project_id
  hostname           = local.instance_name
  region             = var.region
  instance_template  = module.mig_template.self_link
  target_size        = var.target_size

  /* autoscaler */
  autoscaling_enabled = true
  cooldown_period     = var.cooldown_period
}
