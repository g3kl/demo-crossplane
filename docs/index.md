# Using Crossplane to Automate Dynatrace Configuration as Code on Kubernetes

--8<-- "snippets/disclaimer.md"
--8<-- "snippets/view-code.md"

In this hands-on demo, you will use [Crossplane](https://crossplane.io){target=_blank} and [Terraform](https://docs.dynatrace.com/docs/manage/configuration-as-code/terraform){target=_blank} configuration as code to keep Dynatrace in sync automatically.

1. You fork [this repository](https://github.com/dynatrace/demo-crossplane){target=_blank}
1. Terraform code is stored in your forked Git repository
1. Crossplane watches this Git repo
1. Crossplane ensures the state declared in Git == the state in Dynatrace

!!! tip "Larger Images"
    To enlarge images, right click and open in new tab.

![logical flow](images/auto-tags-dt-ui.png)

## Compatibility

| Deployment         | Tutorial Compatible |
|--------------------|---------------------|
| Dynatrace Managed  | ✔️                 |
| Dynatrace SaaS     | ✔️                 |

!!! warning "Fork Repo"
    Fork [this repo](https://github.com/dynatrace/demo-crossplane){target=_blank} before continuing!

    During this tutorial you will need to write to the repo so you need a fork!

<div class="grid cards" markdown>
- [Click Here to Begin :octicons-arrow-right-24:](getting-started.md)
</div>