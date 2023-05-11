# k8s-php-app-canary

## Description

This Helm Chart is designed to deploy apps to a Kubernetes cluster. Under the hood, the Chart generates a lot of YAML files such as deployment.yaml, service.yaml, pdb.yaml etc. All these YAML files are Kubernetes objects.
Also the chart provides advanced deployment capability such as canary. It requires [Argo Rollout](https://argoproj.github.io/argo-rollouts/) to be installed on the Kubernetes cluster.

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

Simple example

```yaml
global:

  image:
    pullPolicy: Always
    repository: pdffiller/fileservice
    tag: v2.0.5

```

Example with canary strategy

```yaml
global:

  image:
    pullPolicy: Always
    repository: pdffiller/fileservice
    tag: v2.0.5

  canary:
    enabled: true
    image:
      repository: airslate/users-api
      tag: canary

```

## Debugging
Commands to generate manifest for debugging purpose:

`helm template test . -f values-local.yaml --dry-run --debug`

`helm install test . -f values-local.yaml --dry-run --debug`

## Parameters

Check [values.yaml](values.yaml)
