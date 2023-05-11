{{/* Labels for web application */}}
{{- define "k8s-php-app-canary.labels" -}}
app: {{ include "k8s-php-app-canary.app_name" . }}
role: web
{{- end -}}

{{/* Metadata for application */}}
{{- define "k8s-php-app-canary.metadata" -}}
name: {{ include "k8s-php-app-canary.app_name" . }}
labels:
{{ include "k8s-php-app-canary.labels" . | indent 2 }}
{{ include "k8s-php-app-canary.extra_labels" . | indent 2 }}
{{- end -}}

{{/* Deployment environment variables */}}
{{- define "k8s-php-app-canary.env_vars" -}}
{{- with .Values.global.env_vars }}
{{- toYaml . }}
{{ end }}
{{- with .Values.env_vars }}
{{- toYaml . }}
{{- end }}
- name: OPEN_TRACING_HOST
  value: $(HOST_IP)
- name: CONSUL_HTTP_ADDR
  value: $(HOST_IP):8500
{{- end -}}

{{/* Deployment EnvFrom ConfigMapRef */}}
{{- define "k8s-php-app-canary.env_config_maps" -}}
{{- if .Values.disable_default_env_from -}}
{{- range .Values.env_config_maps }}
- configMapRef:
    name: {{ . }}
{{- end }}
{{- else -}}
    {{- if .Values.global.family_name -}}
- configMapRef:
    name: {{ printf "%s.%s" "family" .Values.global.family_name }}
    {{- end }}
- configMapRef:
    name: {{ printf "%s.%s" "app"  .Values.global.app_name }}
{{- range .Values.env_config_maps }}
- configMapRef:
    name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}

{{/* Deployment EnvFrom secretRef */}}
{{- define "k8s-php-app-canary.env_secrets" -}}
{{- if .Values.disable_default_env_from -}}
{{- range .Values.env_secrets }}
- secretRef:
    name: {{ . }}
{{- end }}
{{- else -}}
    {{- if .Values.global.family_name -}}
- secretRef:
    name: {{ printf "%s.%s" "family" .Values.global.family_name }}
    {{- end }}
- secretRef:
    name: {{ printf "%s.%s" "app" .Values.global.app_name }}
{{- range .Values.env_secrets }}
- secretRef:
    name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}

{{/* Deployment environment Downward API*/}}
{{- define "k8s-php-app-canary.downward_API" -}}
- name: HOST_IP
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: status.hostIP
- name: POD_NAME
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.name
- name: NAMESPACE_NAME
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.namespace
{{- end -}}

{{/*Deployment dnsConfig */}}
{{- define "k8s-php-app-canary.dnsConfig" -}}
options:
- name: ndots
  value: "2"
- name: single-request-reopen
{{- end -}}

{{/*Deployment lifecycle*/}}
{{- define "k8s-php-app-canary.lifecycle" -}}
postStart:
  exec:
    command:
    - /bin/sh
    - -c
    - "sed \"s/^nameserver.*/nameserver $HOST_IP/g\" /etc/resolv.conf > /tmp/resolv.conf && cat /tmp/resolv.conf > /etc/resolv.conf"
{{- end -}}

{{/* Metadata for prometheus rule manifest */}}
{{- define "k8s-php-app-canary.metadata_promrule" -}}
name: {{ include "k8s-php-app-canary.app_name" . }}
labels:
  prometheus: k8s
{{ include "k8s-php-app-canary.labels" . | indent 2 }}
{{ include "k8s-php-app-canary.extra_labels" . | indent 2 }}
{{- end -}}
