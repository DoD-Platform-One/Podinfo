<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# podinfo

![Version: 6.9.0-bb.0](https://img.shields.io/badge/Version-6.9.0--bb.0-informational?style=flat-square) ![AppVersion: 6.9.0](https://img.shields.io/badge/AppVersion-6.9.0-informational?style=flat-square) ![Maintenance Track: bb_maintainted](https://img.shields.io/badge/Maintenance_Track-bb_maintainted-red?style=flat-square)

Podinfo Helm chart for Kubernetes

## Upstream References

- <https://github.com/stefanprodan/podinfo>
- <https://github.com/stefanprodan/podinfo>

## Upstream Release Notes

This package has no upstream release note links on file. Please add some to [chart/Chart.yaml](chart/Chart.yaml) under `annotations.bigbang.dev/upstreamReleaseNotesMarkdown`.
Example:
```yaml
annotations:
  bigbang.dev/upstreamReleaseNotesMarkdown: |
    - [Find our upstream chart's CHANGELOG here](https://link-goes-here/CHANGELOG.md)
    - [and our upstream application release notes here](https://another-link-here/RELEASE_NOTES.md)
```

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Kubernetes: `>=1.23.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install podinfo chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` |  |
| logLevel | string | `"info"` |  |
| host | string | `nil` |  |
| backend | string | `nil` |  |
| backends | list | `[]` |  |
| image.repository | string | `"registry1.dso.mil/ironbank/opensource/bigbang/podinfo"` |  |
| image.tag | string | `"6.9.0"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| ui.color | string | `"#34577c"` |  |
| ui.message | string | `""` |  |
| ui.logo | string | `""` |  |
| faults.delay | bool | `false` |  |
| faults.error | bool | `false` |  |
| faults.unhealthy | bool | `false` |  |
| faults.unready | bool | `false` |  |
| faults.testFail | bool | `false` |  |
| faults.testTimeout | bool | `false` |  |
| service.enabled | bool | `true` |  |
| service.annotations | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.metricsPort | int | `9797` |  |
| service.httpPort | int | `9898` |  |
| service.externalPort | int | `9898` |  |
| service.grpcPort | int | `9999` |  |
| service.grpcService | string | `"podinfo"` |  |
| service.nodePort | int | `31198` |  |
| service.hostPort | string | `nil` |  |
| h2c.enabled | bool | `false` |  |
| config.path | string | `""` |  |
| config.name | string | `""` |  |
| extraArgs | list | `[]` |  |
| tls.enabled | bool | `false` |  |
| tls.secretName | string | `nil` |  |
| tls.certPath | string | `"/data/cert"` |  |
| tls.port | int | `9899` |  |
| tls.hostPort | string | `nil` |  |
| certificate.create | bool | `false` |  |
| certificate.issuerRef.kind | string | `"ClusterIssuer"` |  |
| certificate.issuerRef.name | string | `"self-signed"` |  |
| certificate.dnsNames[0] | string | `"podinfo"` |  |
| hpa.enabled | bool | `false` |  |
| hpa.maxReplicas | int | `10` |  |
| hpa.cpu | string | `nil` |  |
| hpa.memory | string | `nil` |  |
| hpa.requests | string | `nil` |  |
| cache | string | `""` |  |
| redis.enabled | bool | `false` |  |
| redis.repository | string | `"redis"` |  |
| redis.tag | string | `"7.0.7"` |  |
| serviceAccount.enabled | bool | `true` |  |
| serviceAccount.name | string | `nil` |  |
| serviceAccount.imagePullSecrets[0].name | string | `"private-registry"` |  |
| securityContext.runAsUser | int | `1001` |  |
| securityContext.runAsGroup | int | `1001` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| podSecurityContext | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.additionalLabels | object | `{}` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts[0].host | string | `"podinfo.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| linkerd.profile.enabled | bool | `false` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"15s"` |  |
| serviceMonitor.additionalLabels | object | `{}` |  |
| serviceMonitor.dashboards.namespace | string | `""` |  |
| serviceMonitor.dashboards.label | string | `"grafana_dashboard"` |  |
| resources.limits | string | `nil` |  |
| resources.requests.cpu | string | `"1m"` |  |
| resources.requests.memory | string | `"16Mi"` |  |
| extraEnvs | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| topologySpreadConstraints | list | `[]` |  |
| podDisruptionBudget | object | `{}` |  |
| probes.readiness.initialDelaySeconds | int | `1` |  |
| probes.readiness.timeoutSeconds | int | `5` |  |
| probes.readiness.failureThreshold | int | `3` |  |
| probes.readiness.successThreshold | int | `1` |  |
| probes.readiness.periodSeconds | int | `10` |  |
| probes.liveness.initialDelaySeconds | int | `1` |  |
| probes.liveness.timeoutSeconds | int | `5` |  |
| probes.liveness.failureThreshold | int | `3` |  |
| probes.liveness.successThreshold | int | `1` |  |
| probes.liveness.periodSeconds | int | `10` |  |
| probes.startup.enable | bool | `false` |  |
| probes.startup.initialDelaySeconds | int | `10` |  |
| probes.startup.timeoutSeconds | int | `5` |  |
| probes.startup.failureThreshold | int | `20` |  |
| probes.startup.successThreshold | int | `1` |  |
| probes.startup.periodSeconds | int | `10` |  |
| domain | string | `"dev.bigbang.mil"` |  |
| istiod.enabled | bool | `false` |  |
| istiod.podinfo.enabled | bool | `true` |  |
| istiod.podinfo.gateways[0] | string | `"istio-system/public"` |  |
| istiod.podinfo.hosts[0] | string | `"podinfo.{{ .Values.domain }}"` |  |
| bbtests.enabled | bool | `false` |  |
| bbtests.cypress.artifacts | bool | `true` |  |
| bbtests.cypress.envs.cypress_url | string | `"http://{{ template \"podinfo.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.externalPort }}"` |  |
| bbtests.scripts.envs.URL | string | `"http://{{ template \"podinfo.fullname\" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.externalPort }}"` |  |
| waitJob.enabled | bool | `true` |  |
| waitJob.scripts.image | string | `"registry1.dso.mil/ironbank/opensource/kubernetes/kubectl:v1.30.7"` |  |
| waitJob.permissions.apiGroups | object | `{}` |  |
| waitJob.permissions.resources | object | `{}` |  |
| privateRegistrySecret | bool | `false` |  |
| privateRegistry | string | `"registry1.dso.mil"` |  |
| privateRegistryUsername | string | `""` |  |
| privateRegistryPassword | string | `""` |  |
| privateRegistryEmail | string | `"help@dsop.io"` |  |
| privateRegistrySecretName | string | `"private-registry"` |  |
| autogensecrets.enabled | bool | `true` |  |
| warnInsteadOfFail | bool | `true` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

