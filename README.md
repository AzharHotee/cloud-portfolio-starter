# Cloud Portfolio Starter (Kind + Argo CD + Kubernetes + CI)

This starter helps you spin up a **local, zero-cost** DevOps stack:
- Local Kubernetes via **kind**
- **Argo CD** GitOps for continuous delivery
- A sample **Python/Flask** service containerised with Docker
- Kubernetes manifests managed with **Kustomize**
- Example **GitHub Actions** CI pipeline
- Optional **Terraform** examples for AWS/GCP (commented to avoid charges)

---

## Prerequisites
- Docker Desktop (or Docker Engine)
- `kubectl`
- `kind` (https://kind.sigs.k8s.io/)
- `git`
- Python 3.9+ (for local app testing)

Optional:
- `kustomize` (kubectl v1.14+ has `kubectl kustomize`)
- `helm` (not strictly required)
- Terraform (if you want to try the optional cloud bits later)

---

## Quickstart (Local, Safe & Free)
```bash
# 1) Create a local Kubernetes cluster
./scripts/create_kind.sh

# 2) Install Argo CD into the cluster
./scripts/install_argocd.sh

# 3) Expose the Argo CD UI (port-forward)
./scripts/port_forward_argocd.sh
# Open http://localhost:8080

# 4) Bootstrap GitOps: apply Argo CD Application for the app
kubectl apply -f gitops/apps/hello-app.yaml

# 5) Verify the app is running
kubectl -n hello-app get pods,svc

# 6) Port-forward the service to test locally
kubectl -n hello-app port-forward svc/hello-svc 8000:80
# Then visit http://localhost:8000/ and http://localhost:8000/health
```

### Argo CD Credentials
```bash
# Username: admin
# Password:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

---

## Make a Change & See GitOps in Action
- Edit `app/app.py` (e.g., change the greeting text).
- Rebuild the image and update the Deployment image tag in `k8s/deployment.yaml`.
- Commit & push changes to GitHub (or keep local for demo). Argo CD will detect the change in manifests and sync.

---

## Repo Structure
```
app/                # Sample Flask app + Dockerfile
k8s/                # K8s manifests with Kustomize
gitops/             # Argo CD Application definitions
scripts/            # Helper scripts for cluster lifecycle & Argo CD
.github/workflows/  # CI pipeline (Docker build + lint)
terraform/          # Optional cloud examples (commented to avoid charges)
```

---

## Cleanup
```bash
./scripts/delete_kind.sh
```

---

## Optional: Terraform (Cloud)
**Do this ONLY if you understand potential costs.** The examples under `terraform/aws` and `terraform/gcp` are minimal and commented. If you enable them, set budget alerts in your cloud account and run `terraform destroy` when done.
```bash
cd terraform/aws
# terraform init && terraform plan
# terraform apply
# terraform destroy
```
