# Initialize-PSModule

An action that is used to prepare the runner for PSModule framework.

This GitHub Action is a part of the [PSModule framework](https://github.com/PSModule). It is recommended to use the [Process-PSModule workflow](https://github.com/PSModule/Process-PSModule) to automate the whole process of managing the PowerShell module.

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
| Utilities | Used by all actions, contains common function and classes such as logging and grouping. |
| PSSemVer | Used to create an object for the semantic version numbers. Has functionality to compare, and bump versions. |
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
| Version | The version of the Utilities module to install. | '' (latest) | false |
| Prerelease | Whether to install prerelease versions of the Utilities module. | false | false |
| Shell | The shell to use for running the tests. | pwsh | false |

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
