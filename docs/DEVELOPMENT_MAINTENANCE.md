# Development Maintenance

## How to upgrade

BigBang makes modifications to the upstream helm chart. The full list of changes is at the end of  this document.
1. Read release notes from upstream [podinfo Releases](https://github.com/stefanprodan/podinfo/releases). Be aware of changes that are included in the upgrade, you can find those by [comparing the current and new revision](https://github.com/stefanprodan/podinfo/compare/). Take note of any manual upgrade steps that customers might need to perform, if any.
1. Do diff of [upstream chart](https://github.com/stefanprodan/podinfo/tree/master/charts/podinfo) between old and new release tags to become aware of any significant chart changes. A graphical diff tool such as [Meld](https://meldmerge.org/) is useful. You can see where the current helm chart came from by inspecting `/chart/Kptfile`.
1. Create a development branch and merge request tied to the Repo1 issue created for the podinfo package upgrade.  The association between the branch and the issue can be made by prefixing the branch name with the issue number, e.g. `56-update-podinfo-package`.
1. From the root of this repository, sync the BigBang podinfo package chart with the upstream podinfo chart using `kpt pkg update chart@<target version> --strategy alpha-git-patch`.  Please note that `kpt` > v1.0.0 does *NOT* support this update strategy, and the latest `kpt` version that does is `0.39.2`.
1. Resolve any conflicts that may occur during the `kpt pkg update` process. A graphical diff tool like [Meld](https://meldmerge.org/) is useful. Reference the "Modifications made to upstream chart" section below. Be careful not to overwrite Big Bang Package changes that need to be kept. Note that some files will have combinations of changes that you will overwrite and changes that you keep. Stay alert. The hardest file to update is the `/chart/values.yaml` because the changes are many and complicated.  Once conflicts have been resolved, use `git add` to add the files with resolved conflicts before running `git am --continue` to proceed.
1. Delete all the `/chart/charts/*.tgz` files and the `/chart/requirements.lock`. You will replace these files in a later step.
1. In `/chart/Chart.yaml` in the `.dependencies` update the gluon library to the latest version.
1. Run a helm dependency command to update the `chart/charts/*.tgz` archives and create a new requirements.lock file. You will commit the tar archives along with the requirements.lock that was generated.
    ```bash
    helm dependency update ./chart
    ```
1. In `/chart/values.yaml` update all the podinfo image tags to the new version. Renovate might have already done this for you.
1. Update `/CHANGELOG.md` with an entry for "upgrade podinfo to app version X.X.X chart version X.X.X-bb.X". Or, whatever description is appropriate.
1. Update the `/README.md` following the [gluon library script](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).
1. Use a development environment to deploy and test podinfo. See more detailed testing instructions below. Also test an upgrade by deploying the old version first and then deploying the new version.
1. Update the `/README.md` and `/CHANGELOG.md` again if you have made any additional changes during the upgrade/testing process.

## Big Bang considerations

When deploying with kyverno you will need to add these to your overrides:

```yaml
monitoring:
  enabled: true

kyverno:
  enabled: true

addons:
  argocd: 
    enabled: true

packages:
  podinfo:
    enabled: true
    sourceType: "git"
    git:
      repo: https://repo1.dso.mil/big-bang/apps/sandbox/podinfo.git
      path: chart
      tag: null
      branch: your-branch-name # add your branch name here after you publish it
    flux:
      timeout: 5m
    postRenderers: []
    wrapper:
      enabled: true
    dependsOn:
      - name: monitoring
        namespace: bigbang
    values:
      autogensecrets: 
        enabled: true
      replicaCount: 3
      istio:
        hardened:
          enabled: true
```

```bash
# Run the following command to install:
./docs/assets/scripts/developer/k3d-dev.sh
export KUBECONFIG=~/.kube/$(aws sts get-caller-identity --query "Arn" --output text | cut -d '/' -f2)-dev-default-config
./scripts/install_flux.sh -u $REGISTRY1_USER -p $REGISTRY1_PASSWORD
    helm upgrade -i bigbang chart/ -n bigbang --create-namespace \
    --set registryCredentials.username=${REGISTRY1_USER} \
    --set registryCredentials.password="${REGISTRY1_PASSWORD}" \
    -f ./docs/assets/configs/example/policy-overrides-k3d.yaml \
    -f ./chart/ingress-certs.yaml \
    -f /your/podinfo/override/file/location/override.yaml
```

- Kyverno is a hard requirements for testing, because kyverno will be needed for policy replication
- ArgoCD is a soft requirements, if not present then make sure to specify in an additional override file the following values:

```yaml
privateRegistrySecret: true
privateRegistry: "registry1.dso.mil"
privateRegistryUsername: "your_harbor_username"
privateRegistryPassword: "your_harbor_password"
privateRegistryEmail: "help@dsop.io"
privateRegistrySecretName: "private-registry"
```

```bash
# Run the following command to install:
./docs/assets/scripts/developer/k3d-dev.sh
export KUBECONFIG=~/.kube/$(aws sts get-caller-identity --query "Arn" --output text | cut -d '/' -f2)-dev-default-config
./scripts/install_flux.sh -u $REGISTRY1_USER -p $REGISTRY1_PASSWORD
    helm upgrade -i bigbang chart/ -n bigbang --create-namespace \
    --set registryCredentials.username=${REGISTRY1_USER} \
    --set registryCredentials.password="${REGISTRY1_PASSWORD}" \
    -f ./docs/assets/configs/example/policy-overrides-k3d.yaml \
    -f ./chart/ingress-certs.yaml \
    -f /your/podinfo/override/file/location/override.yaml \
    -f /your/podinfo/credentials/file/location/credentials.yaml
```

### Testing

How to run tests:

```bash
helm test -n podinfo podinfo
```

You will need to add these to your overrides to run tests when using kyverno:

```yaml
kyvernoPolicies:
  values:
    policies:
      restrict-image-registries:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      restrict-host-path-mount:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      restrict-host-path-write:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      restrict-volume-types:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      require-non-root-group:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      require-non-root-user:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      disallow-image-tags:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
      require-drop-all-capabilities:
        exclude:
          any:
            - resources:
                namespaces:
                  - podinfo
                names:
                  - podinfo*
```

## Changes from upstream

### `chart/charts/*`
- Added everything in this folder

### `chart/dashboards/*`
- Added everything in this folder

### `chart/templates/tests/bigbang/*`
- Added everything in this folder

### `chart/templates/tests/cache.yaml`
- Add the optional service account
	```yaml
	{{- if .Values.serviceAccount.enabled }}
	serviceAccountName: {{ template "podinfo.serviceAccountName" . }}
	{{- end }}
	```
- Changed the `spec.containers.[name=curl].image` to `curlimages/curl:7.69`

### `chart/templates/tests/cypress-test.yaml`
- Added

### `chart/templates/tests/grpc.yaml`
- Removed because it always fails

### `chart/templates/tests/jwt.yaml`
- Removed because it always fails

### `chart/templates/tests/script-test.yaml`
- Added

### `chart/templates/tests/service.yaml`
- Removed because it always fails

### `chart/templates/tests/tls.yaml`
- Add the optional service account
	```yaml
	{{- if .Values.serviceAccount.enabled }}
	serviceAccountName: {{ template "podinfo.serviceAccountName" . }}
	{{- end }}
	```
- Changed the `spec.containers.[name=curl].image` to `curlimages/curl:7.69`

### `chart/templates/deployment.yaml`
- Added custom labels
	```yaml
	{{- range $key, $value := .Values.podLabels }}
	{{ $key }}: {{ $value | quote }}
	{{- end }}
	```

### `chart/tests/*`
- Added everything in this folder

### `chart/Chart.yaml`
- Added `.dependencies`
- Added `.icon`
- Added `-bb.*` to `.version`
- Updated the `.apiVersion` to 2

### `chart/Kptfile`
- Added

### `chart/requirements.lock`
- Added

### `chart/values.yaml`
- Updated the `.securityContext`
	```yaml
	securityContext:
		runAsUser: 1001
		runAsGroup: 1001
		runAsNonRoot: true
		capabilities:
			drop:
			- ALL
	```
- Added `.ingress.dashboards`
	```yaml
	dashboards:
		# Namespace to put .json ConfigMap so Grafana sidecar will find it
		namespace: ""
		# Label to apply to dashboard so Grafana sidecar will find it
		label: grafana_dashboard
	```
- Added everything under the comment `# Big Bang Values`
