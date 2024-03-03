# Initialize-PSModule

An action that is used to prepare the runner for PSModule framework.

## Specifications and practices

Initiate-PSModule follows:

- [SemVer 2.0.0 specifications](https://semver.org)
- [GitHub Flow specifications](https://docs.github.com/en/get-started/using-github/github-flow)
- [Continiuous Delivery practices](https://en.wikipedia.org/wiki/Continuous_delivery)

... and supports the following practices in the PSModule framework:

- [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

## How it works

The Initialize-PSModule action will prepare the runner for the PSModule framework by installing the following dependencies:

| Module | Description |
| --- | --- |
| Utilities | Used by all actions, contains common function and classes such as logging, grouping and the [PSSemVer] class. |
| powershell-yaml | Used to parse and serialize YAML files, typically for reading configuration files. |
| Pester | Used for testing PowerShell code. |
| PSScriptAnalyzer | Used to lint and format PowerShell code. |
| platyPS | Used to generate Markdown documentation from PowerShell code. |

It also makes the following environment variables available to the runner:

| Variable | Description |
| --- | --- |
| GITHUB_REPOSITORY_NAME | Contains the name of the repository, used to automatically act as the name of the module. |

## Usage

The action can be configured using the following settings:

| Name | Description | Default | Required |
| --- | --- | --- | --- |
| | | | |

### Configuration file

There are no configuration settings for the Initialize-PSModule action.

## Example

The action can be used in a workflow to prepare the runner for the PSModule framework by adding it at the start of the workflow.

```yaml
name: Process-PSModule

on: [push]

jobs:
  Process-PSModule:
    name: Process module
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Initialize environment
        uses: PSModule/Initialize-PSModule@main
```

## Permissions

The action does not require any permissions.
