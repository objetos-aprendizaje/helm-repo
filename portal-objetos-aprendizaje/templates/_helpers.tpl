{{/*
Expand the name of the chart.
*/}}
{{- define "portal-objetos-aprendizaje.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "portal-objetos-aprendizaje.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "portal-objetos-aprendizaje.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "portal-objetos-aprendizaje.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "portal-objetos-aprendizaje.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "portal-objetos-aprendizaje.labels" -}}
helm.sh/chart: {{ include "portal-objetos-aprendizaje.chart" . }}
{{/* include "portal-objetos-aprendizaje.selectorLabels" . */}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{/*
Selector labels admin portal
*/}}
{{- define "portal-objetos-aprendizaje-admin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "portal-objetos-aprendizaje.name" . }}-admin
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels web portal
*/}}
{{- define "portal-objetos-aprendizaje-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "portal-objetos-aprendizaje.name" . }}-web
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels mysql
*/}}
{{- define "portal-objetos-aprendizaje-mysql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "portal-objetos-aprendizaje.name" . }}-mysql
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels kafka
*/}}
{{- define "portal-objetos-aprendizaje-kafka.selectorLabels" -}}
app.kubernetes.io/name: {{ include "portal-objetos-aprendizaje.name" . }}-kafka
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels zookeeper
*/}}
{{- define "portal-objetos-aprendizaje-zookeeper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "portal-objetos-aprendizaje.name" . }}-zookeeper
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

