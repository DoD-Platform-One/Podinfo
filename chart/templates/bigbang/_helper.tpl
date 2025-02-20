{{- define "privateRegistryAuth" -}}
{"auths":{"{{ .Values.privateRegistry }}":{"username":"{{ .Values.privateRegistryUsername }}","password":"{{ .Values.privateRegistryPassword }}","auth":"{{ printf "%s:%s" .Values.privateRegistryUsername .Values.privateRegistryPassword | b64enc }}"}}}
{{- end }}
