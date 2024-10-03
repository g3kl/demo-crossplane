#!/bin/bash

#############################################################################
# Build URL from parts
full_apps_url="https://${DT_ENV_ID_OBSLAB_CROSSPLANE}"
full_gen2_url=""

if [ "${DT_ENVIRONMENT_OBSLAB_CROSSPLANE}" = "dev" ]; then
  echo "environment is dev"
  full_apps_url+=".dev.apps.dynatracelabs.com"
  # Remove apps.
  full_gen2_url=${full_apps_url/apps.}
elif [ "${DT_ENVIRONMENT_OBSLAB_CROSSPLANE}" = "sprint" ]; then
  echo "environment is sprint"
  full_apps_url+=".sprint.apps.dynatracelabs.com"
  # Remove apps.
  full_gen2_url=${full_apps_url/apps.}
else
  echo "DT_ENVIRONMENT_OBSLAB_CROSSPLANE is either 'live' or some other value. Defaulting to live"
  full_apps_url+=".apps.dynatrace.com"
  full_gen2_url=${full_apps_url/.apps./.live.}
fi

#############################################################################
# Create cluster
kind create cluster --config .devcontainer/kind-cluster.yml --wait 300s

kubectl create namespace crossplane-system

kubectl -n crossplane-system create secret generic dt-details \
  --from-literal=DYNATRACE_ENV_URL=$full_gen2_url \
  --from-literal=DYNATRACE_API_TOKEN=$DT_API_TOKEN_OBSLAB_CROSSPLANE

# Install Crossplane
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane --namespace crossplane-system --wait crossplane-stable/crossplane --values crossplane-values.yaml

kubectl apply -f terraform-config.yaml
kubectl -n crossplane-system wait pod --for condition=Ready -l pkg.crossplane.io/provider=provider-terraform

kubectl apply -f terraform-provider-config.yaml

# Creation Ping
# curl -X POST https://grzxx1q7wd.execute-api.us-east-1.amazonaws.com/default/codespace-tracker \
#   -H "Content-Type: application/json" \
#   -d "{
#     \"tenant\": \"$DT_ENV_ID_OBSLAB_CROSSPLANE\",
#     \"dt_environment\": \"$DT_ENVIRONMENT_OBSLAB_CROSSPLANE\",
#     \"repo\": \"$GITHUB_REPOSITORY\",
#     \"demo\": \"obslab-crossplane\",
#     \"codespace.name\": \"$CODESPACE_NAME\"
#   }"