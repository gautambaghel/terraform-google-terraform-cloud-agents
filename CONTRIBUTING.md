# Contributing

This document provides guidelines for contributing to the module.

## Dependencies

The following dependencies must be installed on the development system:

- [Docker Engine][docker-engine]
- [Google Cloud SDK][google-cloud-sdk]
- [make]
- [pre-commit]
- [terraform-docs]
- [tflint]

For more info refer the [tool-versions file](.tool-versions)

## Generating Documentation for Inputs and Outputs

The Inputs and Outputs tables in the READMEs of the root module,
submodules, and example modules are automatically generated based on
the `variables` and `outputs` of the respective modules. These tables
must be refreshed if the module interfaces are changed.

### Execution

Run `make generate_docs` to generate new Inputs and Outputs tables.

## Linting and Formatting

Many of the files in the repository can be linted or formatted to
maintain a standard of quality.

When working with the repository for the first time run pre-commit

Run `pre-commit install`
Run `pre-commit run --all-files`

### Execution

Run `make test_lint`.

[docker-engine]: https://www.docker.com/products/docker-engine
[google-cloud-sdk]: https://cloud.google.com/sdk/install
[make]: https://en.wikipedia.org/wiki/Make_(software)
[pre-commit]: https://pre-commit.com/
[terraform-docs]: https://github.com/segmentio/terraform-docs
[tflint]: https://github.com/terraform-linters/tflint
