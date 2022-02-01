module "app-infra" {
  source = "../../modules/app-infra"

  project_id = var.project_id
  region     = var.region

  cloudsql_instance_name = var.cloudsql_instance_name
  namespace              = var.namespace

  dns_project_id      = var.dns_project_id
  managed_zone        = var.managed_zone
  create_vouch_record = var.enable_auth

  bucket_force_destroy = true

}

module "okta-netbox-app" {
  source = "../../modules/okta-application"

  enable_auth = var.enable_auth
  org_name    = var.okta_org_name

  resource_prefix = var.okta_resource_prefix

  name = var.namespace

  redirect_uris = [
    "https://${module.app-infra.vouch_host}/auth"
  ]
  post_logout_redirect_uris = [
    "https://${module.app-infra.netbox_host}"
  ]

  base_url = var.okta_base_url

  assignment_group_name = var.okta_assignment_group_name

}