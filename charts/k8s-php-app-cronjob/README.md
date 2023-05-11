# k8s-php-app-cronjob.

## Description

This Helm Chart is designed to deploy a php cronjob to a Kubernetes cluster.
## Contents

- [Description](#description)
- [Contents](#contents)
- [Requirements](#requirements)
- [Usage examples](#usage-examples)
- [Debugging](#debugging)
- [Parameters](#parameters)

## Requirements

To use this module following utilities should be present on running machine:
- bash
- [helm](https://helm.sh/docs/intro/install/) >= v3.3.0

## Usage examples

Example of `Chart.yaml`

```yaml
apiVersion: v2
version: 1.0
name: fileservice

dependencies:
- name: k8s-php-app-cronjob.
  version: 0.0.1
  repository: https://raw.githubusercontent.com/pdffiller/pdffiller-microservices-infra/charts/charts
  alias: space-cleanup
```

Example of `values.yaml`

```yaml
global:

  image:
    pullPolicy: Always
    repository: pdffiller/fileservice
    tag: v2.0.5

space-cleanup:
  env_vars:
  - name: far
    value: bar

  env_config_maps:
  - my.map
  env_secrets:
  - my.secrets
```

## Debugging
Commands to generate manifest for debugging purpose:

`helm template test . -f values-local.yaml --dry-run --debug`

`helm install test . -f values-local.yaml --dry-run --debug`

## Parameters

Check [values.yaml](values.yaml)
