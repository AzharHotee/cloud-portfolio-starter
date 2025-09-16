#!/usr/bin/env bash
set -euo pipefail
kind delete cluster --name cloud-portfolio || true
docker rm -f kind-registry || true
