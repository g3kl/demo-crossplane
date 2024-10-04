# Crossplane Observability

!!! warning "Under Construction"
    This section is a work in progress.

Crossplane is running but it makes sense that we should be making sure that Crossplane is behaving correctly.

Let's start by sending the metrics from crossplane into Dynatrace.

## 1. Enable Metrics

!!! info "Enable Helm"
    This has already been done during the initial setup of the demo environment.

    This section is for your information only. No action is required.

[The Crossplane docs](https://docs.crossplane.io/latest/guides/metrics/){target=_blank} mention that to enable metrics, the following property needs to be set via Helm. This is already done in the demo system.

```
metrics:
  enabled: true
```

## 2. Ensure Pods are Annotated

By default, crossplane pods and most providers will have prometheus metrics and be annotated with the correct annotations to make them "scraping ready".

You can check this with the following commands:

```
kubectl -n crossplane-system describe pod -l app.kubernetes.io/name=crossplane
kubectl -n crossplane-system describe pod -l app.kubernetes.io/name=provider-crossplane
```

Each pod returned from those queries should include the relevant annotations:

```
Name:             crossplane-7fd45dd86d-gnk65
Namespace:        crossplane-system
...
Annotations:      prometheus.io/path: /metrics
                  prometheus.io/port: 8080
                  prometheus.io/scrape: true
```

## Install OpenTelemetry Collector

```

```
