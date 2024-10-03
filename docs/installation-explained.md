## Wait for System

The system may still be loading.

Wait until the `Running postCreate command` loading spinner disappears.

Wait here until the terminal prompt looks like this (your username will differ).

![codespace interactive](images/codespace-interactive.png)

## Setup and Configuration Explanation

The codespace automatically creates a Kubernetes cluster.

Onto that cluster, the startup script:

* Creates a namespace `crossplane-system`
* Creates a secret in that namespace `dt-details` which stores your Dynatrace endpoint and API token
* Installs the Crossplane Terraform provider and configures it to run in debug mode, poll repositories every minute and attemp a maximum of 10 concurrent reconcilliations (see [terraform-config.yaml](https://github.com/Dynatrace/obslab-crossplane/blob/main/terraform-config.yaml){target=_blank})
* Configures the Crossplane Terraform provider to use the Dynatrace provider (see [terraform-provider-config.yaml](https://github.com/Dynatrace/obslab-crossplane/blob/main/terraform-provider-config.yaml){target=_blank})
* Modifies [workspace-remote.yaml](https://github.com/Dynatrace/obslab-crossplane/blob/main/workspace-remote.yaml){target=_blank} to point to your repository


!!! info "Summary"
    Crossplane is now running and watching the `config_as_code` folder of your repository.

    Crossplane will ensure that configurations in that folder are applied to your Dynatrace environment

<div class="grid cards" markdown>
- [Click Here to Continue :octicons-arrow-right-24:](view-configuration.md)
</div>