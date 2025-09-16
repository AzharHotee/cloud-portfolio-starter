#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD server rollout..."
kubectl -n argocd rollout status deploy/argocd-server --timeout=180s || true

echo "Argo CD installed. Get password with:"
echo 'kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo'
