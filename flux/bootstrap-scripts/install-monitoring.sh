#!/usr/bin/env sh

 set -e

 flux create source git flux-monitoring \
   --interval=30m \
   --url=https://github.com/fluxcd/flux2 \
   --branch=main

 flux create kustomization kube-prometheus-stack \
   --interval=10m \
   --prune \
   --source=flux-monitoring \
   --path="./manifests/monitoring/kube-prometheus-stack" \
   --health-check-timeout=5m \
   --wait

 flux create kustomization loki-stack \
   --depends-on=kube-prometheus-stack \
   --interval=10m \
   --prune \
   --source=flux-monitoring \
   --path="./manifests/monitoring/loki-stack" \
   --health-check-timeout=5m \
   --wait

 flux create kustomization monitoring-config \
   --depends-on=kube-prometheus-stack \
   --interval=10m \
   --prune=true \
   --source=flux-monitoring \
   --path="./manifests/monitoring/monitoring-config" \
   --health-check-timeout=1m \
   --wait