{{/* Labels */}}
{{- define "k8s-php-app-cronjob.labels" -}}
app: {{ include "k8s-php-app-cronjob.app_name" . }}
role: {{ include "k8s-php-app-cronjob.kind" . }}
{{- end -}}

{{/* Metadata */}}
{{- define "k8s-php-app-cronjob.metadata" -}}
name: {{ include "k8s-php-app-cronjob.fullname" . }}
labels:
{{ include "k8s-php-app-cronjob.labels" . | indent 2 }}
{{- end -}}

{{/* Environment variables */}}
{{- define "k8s-php-app-cronjob.env_vars" -}}
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

{{/* EnvFrom ConfigMapRef */}}
{{- define "k8s-php-app-cronjob.env_config_maps" -}}
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

{{/* EnvFrom secretRef */}}
{{- define "k8s-php-app-cronjob.env_secrets" -}}
{{- if .Values.disable_default_env_from -}}
{{- range .Values.env_secrets }}
- secretRef:
    name: {{ . }}
{{- end }}
{{- else -}}
- secretRef:
    name: {{ printf "%s.%s" "app" .Values.global.app_name }}
{{- range .Values.env_secrets }}
- secretRef:
    name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}
