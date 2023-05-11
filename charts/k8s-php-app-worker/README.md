# k8s-php-app-worker

## Description

This Helm Chart is designed to deploy a php worker app to a Kubernetes cluster. Under the hood, the Chart generates a lot of YAML files such as deployment.yaml, hpa.yaml, pdb.yaml etc. All these YAML files are Kubernetes objects.

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
name: microservice

dependencies:
- name: k8s-php-app-worker
  version: 0.0.1
  repository: https://raw.githubusercontent.com/pdffiller/pdffiller-microservices-infra/master/charts
  alias: redis

- name: k8s-php-app-worker
  version: 0.0.1
  repository: https://raw.githubusercontent.com/pdffiller/pdffiller-microservices-infra/master/charts
  alias: rabbit
```

Example of `values.yaml`

```yaml
global:

  image:
    pullPolicy: Always
    repository: pdffiller/fileservice
    tag: v2.0.5

redis:
  autoscaling:
    enabled: true

rabbit:
  autoscaling:
    enabled: true
    metrics:
    - metric: "rabbit"
      value: "100"

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
