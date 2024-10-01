# obslab-crossplane

> :warning: This is a work in progress

```
# Create Cluster
kind create cluster
# Install Crossplane
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane --namespace crossplane-system --create-namespace \
crossplane-stable/crossplane 

# Wait for all pods to start
kubectl -n crossplane-system wait --for=condition=Ready --all --timeout 120s pod
```
