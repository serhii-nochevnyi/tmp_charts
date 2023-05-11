{{/* Define app_name variable*/}}
{{- define "k8s-php-app-cronjob.app_name" -}}
{{- required "Values.global.app_name entry required!" .Values.global.app_name -}}
{{- end -}}

{{/* Define namespace variable*/}}
{{- define "k8s-php-app-cronjob.namespace" -}}
{{- required "Values.global.namespace entry required!" .Values.global.namespace -}}
{{- end -}}

{{/* Define role variable*/}}
{{- define "k8s-php-app-cronjob.role" -}}
{{- required "Values.role entry required!" .Values.role -}}
{{- end -}}

{{/* Define kind variable*/}}
{{- define "k8s-php-app-cronjob.kind" -}}
{{- required "Values.kind entry required!" .Values.kind -}}
{{- end -}}

{{/* Define fullname variable */}}
{{- define "k8s-php-app-cronjob.fullname" -}}
{{ include "k8s-php-app-cronjob.app_name" . }}-{{ include "k8s-php-app-cronjob.kind" . }}
{{- end -}}

{{/* Define service_name variable*/}}
{{- define "k8s-php-app-cronjob.sevice_name" -}}
{{- $environment := required "Values.global.environment entry required!" .Values.global.environment -}}
{{- if .Values.global.family_name }}
{{- printf "%s-%s"  $environment  .Values.global.family_name }}-{{ include "k8s-php-app-cronjob.fullname" . }}
{{- else }}
{{- printf "%s"  $environment }}-{{ include "k8s-php-app-cronjob.fullname" . }}
{{- end }}
{{- end -}}


{{/* Define image_name variable*/}}
{{- define "k8s-php-app-cronjob.image_name" -}}
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
