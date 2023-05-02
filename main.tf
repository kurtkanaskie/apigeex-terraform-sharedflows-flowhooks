# Shared flows and flow hooks
provider "google" {
  project = var.project_id
}

## ---------------------------------------------------------------------------------------------------------------------
## ---------------------------------------------------------------------------------------------------------------------
## Standalone Shared Flows and Deplyments
## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-cors-any-v1
resource "google_apigee_sharedflow" "tf_cors_any_v1" {
  name            = "tf-cors-any-v1"
  org_id          = var.project_id
  config_bundle   = "./src/tf-cors-any-v1/tf-cors-any-v1.zip"
}

## Shared Flow tf-cors-any-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_cors_any_v1_deployment" {
  environment = var.env
  org_id        = google_apigee_sharedflow.tf_cors_any_v1.org_id
  revision      = google_apigee_sharedflow.tf_cors_any_v1.revision[length(google_apigee_sharedflow.tf_cors_any_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_cors_any_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-log-set-values-v1
resource "google_apigee_sharedflow" "tf_log_set_values_v1" {
  name            = "tf-log-set-values-v1"
  org_id          = var.project_id
  config_bundle   = "./src/tf-log-set-values-v1/tf-log-set-values-v1.zip"
}

## Shared Flow tf-cors-any-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_log_set_values_v1_deployment" {
  environment = var.env
  org_id        = google_apigee_sharedflow.tf_log_set_values_v1.org_id
  revision      = google_apigee_sharedflow.tf_log_set_values_v1.revision[length(google_apigee_sharedflow.tf_log_set_values_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_log_set_values_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-log-cloud-logging-sc-v1
resource "google_apigee_sharedflow" "tf_log_cloud_logging_sc_v1" {
  name            = "tf-log-cloud-logging-sc-v1"
  org_id          = var.project_id
  config_bundle   = "./src/tf-log-cloud-logging-sc-v1/tf-log-cloud-logging-sc-v1.zip"
}

## Shared Flow tf-log-cloud-logging-sc-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf-log-cloud-logging-sc-v1_deployment" {
  environment     = var.env
  org_id          = google_apigee_sharedflow.tf_log_cloud_logging_sc_v1.org_id
  revision        = google_apigee_sharedflow.tf_log_cloud_logging_sc_v1.revision[length(google_apigee_sharedflow.tf_log_cloud_logging_sc_v1.revision)-1]
  sharedflow_id   = google_apigee_sharedflow.tf_log_cloud_logging_sc_v1.name
  service_account = "apiproxy-logging@apigeex-mint-kurt.iam.gserviceaccount.com"

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## ---------------------------------------------------------------------------------------------------------------------
## FlowHook Locations Shared Flows and Deplyments
## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-pre-proxy-v1
resource "google_apigee_sharedflow" "tf_pre_proxy_v1" {
  name          = "tf-pre-proxy-v1"
  org_id        = var.project_id
  config_bundle = "./src/tf-pre-proxy-v1/tf-pre-proxy-v1.zip"
}

## Shared Flow tf-pre-proxy-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_pre_proxy_v1_deployment" {
  environment = var.env
  org_id        = google_apigee_sharedflow.tf_pre_proxy_v1.org_id
  revision      = google_apigee_sharedflow.tf_pre_proxy_v1.revision[length(google_apigee_sharedflow.tf_pre_proxy_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_pre_proxy_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-pre-target-v1
resource "google_apigee_sharedflow" "tf_pre_target_v1" {
  name          = "tf-pre-target-v1"
  org_id        = var.project_id
  config_bundle = "./src/tf-pre-target-v1/tf-pre-target-v1.zip"
}

## Shared Flow tf-pre-target-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_pre_target_v1_deployment" {
  environment = var.env
  org_id        = google_apigee_sharedflow.tf_pre_target_v1.org_id
  revision      = google_apigee_sharedflow.tf_pre_target_v1.revision[length(google_apigee_sharedflow.tf_pre_target_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_pre_target_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-post-target-v1
resource "google_apigee_sharedflow" "tf_post_target_v1" {
  name          = "tf-post-target-v1"
  org_id        = var.project_id
  config_bundle = "./src/tf-post-target-v1/tf-post-target-v1.zip"
}

## Shared Flow tf-post-target-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_post_target_v1_deployment" {
  environment = var.env
  org_id        = google_apigee_sharedflow.tf_post_target_v1.org_id
  revision      = google_apigee_sharedflow.tf_post_target_v1.revision[length(google_apigee_sharedflow.tf_post_target_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_post_target_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## Shared Flow tf-post-proxy-v1
resource "google_apigee_sharedflow" "tf_post_proxy_v1" {
  name          = "tf-post-proxy-v1"
  org_id        = var.project_id
  config_bundle = "./src/tf-post-proxy-v1/tf-post-proxy-v1.zip"
}

## Shared Flow tf-post-proxy-v1 deployment
resource "google_apigee_sharedflow_deployment" "tf_post_proxy_v1_deployment" {
  environment   = var.env
  org_id        = google_apigee_sharedflow.tf_post_proxy_v1.org_id
  revision      = google_apigee_sharedflow.tf_post_proxy_v1.revision[length(google_apigee_sharedflow.tf_post_proxy_v1.revision)-1]
  sharedflow_id = google_apigee_sharedflow.tf_post_proxy_v1.name

  lifecycle {
    create_before_destroy = true
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## ---------------------------------------------------------------------------------------------------------------------
## FlowHook Locations Shared Flows and Deplyments
## ---------------------------------------------------------------------------------------------------------------------
## Flow Hoow PreProxyFlowHook
resource "google_apigee_flowhook" "tf_pre_proxy_flow_hook" {
    org_id            = google_apigee_sharedflow.tf_pre_proxy_v1.org_id
    environment       = var.env
    flow_hook_point   = "PreProxyFlowHook"
    sharedflow        = google_apigee_sharedflow.tf_pre_proxy_v1.name
    description       = "TF tf-pre-proxy-v1"
    continue_on_error = true
}

## Flow Hoow PreTargetFlowHook
resource "google_apigee_flowhook" "tf_pre_target_flow_hook" {
    org_id            = google_apigee_sharedflow.tf_pre_target_v1.org_id
    environment       = var.env
    flow_hook_point   = "PreTargetFlowHook"
    sharedflow        = google_apigee_sharedflow.tf_pre_target_v1.name
    description       = "TF tf-pre-target-v1"
    continue_on_error = true
}

## Flow Hoow PostTargetFlowHook
resource "google_apigee_flowhook" "tf_post_target_flow_hook" {
    org_id            = google_apigee_sharedflow.tf_post_target_v1.org_id
    environment       = var.env
    flow_hook_point   = "PostTargetFlowHook"
    sharedflow        = google_apigee_sharedflow.tf_post_target_v1.name
    description       = "TF tf-post-target-v1"
    continue_on_error = true
}

## Flow Hoow PostProxyFlowHook
resource "google_apigee_flowhook" "tf_post_proxy_flow_hook" {
    org_id            = google_apigee_sharedflow.tf_post_proxy_v1.org_id
    environment       = var.env
    flow_hook_point   = "PostProxyFlowHook"
    sharedflow        = google_apigee_sharedflow.tf_post_proxy_v1.name
    description       = "TF tf-post-proxy-v1"
    continue_on_error = true
}

