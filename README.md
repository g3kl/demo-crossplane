# obslab-crossplane

> :warning: This is a work in progress

## Create Cluster

Download and add [kind](https://kind.sigs.k8s.io) to your `PATH`.

Then create a cluster.

```
kind create cluster
```

## Create Crossplane Namespace

```
kubectl create namespace crossplane-system
```

## Create DT Secret

Create a secret that the Terraform Provider for crossplane
will use to connect to Dynatrace

```
kubectl -n crossplane-system dt-details \
  --from-literal=DYNATRACE_ENV_URL=https://abc12345.live.dynatrace.com \
  --from-literal=DYNATRACE_API_TOKEN=dt0c01.secret.sample
```

## Install Crossplane on Cluster
```
# Install Crossplane
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane --namespace crossplane-system --create-namespace \
crossplane-stable/crossplane 

# Wait for all pods to start
kubectl -n crossplane-system wait --for=condition=Ready --all --timeout 120s pod
```

# Install and Configure Terraform provider

```
kubectl apply -f terraform-config.yaml
```
