# obslab-crossplane

> :warning: This is a work in progress

## Fork this repository

You will be making changes to the code in this repo. So begin by forking this repo to your own account.

Make all changes in your fork.

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

1. Generate a Dynatrace access token (for the configuration in this demo you only
   need `settings.read` and `settings.write` but your token permissions will vary
   if you add different types of config).

   See [here](https://registry.terraform.io/providers/dynatrace-oss/dynatrace/latest/docs) for more info.


Create a secret that the Terraform Provider for crossplane
will use to connect to Dynatrace

```
kubectl -n crossplane-system dt-details \
  --from-literal=DYNATRACE_ENV_URL=https://abc12345.live.dynatrace.com \
  --from-literal=DYNATRACE_API_TOKEN=dt0c01.sample.secret
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

## Install and Configure Terraform provider

```
kubectl apply -f terraform-config.yaml
```

## Point Crossplane to your Fork

* ✔️ Crossplane is installed
* ✔️ Terraform is installed

However, we haven't told terraform **where** the Dynatrace configuration as code lives.
This is done via a `Workspace` custom resource.

Modify `workspace-remote.yaml` and change `dynatrace/obslab-crossplane` to the details of your fork.

For example, if your account was `SomeUser` and the repo was called `obslab-crossplane` then line 8 would look like this:

``
    module: git::https://github.com/SomeUser/obslab-crossplane?ref=main`
``

Apply that file:

```
kubectl apply -f workspace-remote.yaml
```




