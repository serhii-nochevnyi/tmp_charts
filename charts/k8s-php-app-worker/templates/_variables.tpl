{{/* Define app_name variable*/}}
{{- define "k8s-php-app-worker.app_name" -}}
{{- required "Values.global.app_name entry required!" .Values.global.app_name -}}
{{- end -}}

{{/* Define namespace variable*/}}
{{- define "k8s-php-app-worker.namespace" -}}
{{- required "Values.global.namespace entry required!" .Values.global.namespace -}}
{{- end -}}

{{/* Define role variable*/}}
{{- define "k8s-php-app-worker.role" -}}
{{- required "Values.type entry required!" .Values.role -}}
{{- end -}}

{{/* Define fullname variable */}}
{{- define "k8s-php-app-worker.fullname" -}}
{{ include "k8s-php-app-worker.app_name" . }}-{{ include "k8s-php-app-worker.role" . }}
{{- end -}}

{{/* Define promrule record name */}}
{{- define "k8s-php-app-worker.promrule_record" -}}
{{ .Values.global.metric_prefix }}_{{ include "k8s-php-app-worker.fullname" . | replace "-" "_" }}_worker
{{- end -}}

{{/* Define consul_service_name variable*/}}
{{- define "k8s-php-app-worker.sevice_name" -}}
{{- $environment := required "Values.global.environment entry required!" .Values.global.environment -}}
{{- if .Values.global.family_name }}
{{- printf "%s-%s-%s"  $environment  .Values.global.family_name  .Values.global.app_name }}
{{- else }}
{{- printf "%s-%s"  $environment .Values.global.app_name }}
{{- end }}
{{- end -}}

{{/* Define image_name variable*/}}
{{- define "k8s-php-app-worker.image_name" -}}
{{- if .Values.global.canary.enabled -}}
{{- $repo_name := required "Values.global.canary.image.repository entry required!" .Values.global.canary.image.repository -}}
{{- $tag := required "Values.global.canary.image.tag entry required!" .Values.global.canary.image.tag -}}
{{- printf "%s:%s" $repo_name $tag }}
{{- else }}
{{- $repo_name := required "Values.global.image.repository entry required!" .Values.global.image.repository -}}
{{- $tag := required "Values.global.image.tag entry required!" .Values.global.image.tag -}}
{{- printf "%s:%s" $repo_name $tag }}
{{- end }}
{{- end -}}

{{/* Define extra labels */}}
{{- define "k8s-php-app-worker.extra_labels" -}}
{{- range $k, $v := .Values.global.labels }}
{{ $k }}: {{ $v }}
{{- end -}}
{{- end -}}
