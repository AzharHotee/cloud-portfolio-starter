#!/usr/bin/env bash
set -euo pipefail

cat <<EOF | kind create cluster --name cloud-portfolio --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
    endpoint = ["http://kind-registry:5000"]
EOF

# Optional: local registry for dev images
running="$(docker inspect -f '{{.State.Running}}' kind-registry 2>/dev/null || true)"
if [ "${running}" != "true" ]; then
  docker run -d --restart=always -p "5000:5000" --name "kind-registry" registry:2
fi

# Connect registry to cluster network
docker network connect "kind" "kind-registry" || true

# Document the local registry
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:5000"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF

echo "Kind cluster 'cloud-portfolio' is ready."
