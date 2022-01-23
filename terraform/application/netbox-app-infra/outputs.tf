output "bucket" {
  value = module.app-infra.bucket
}

output "redis_host" {
  value = module.app-infra.redis_host
}

output "external_ip" {
  value = module.app-infra.external_ip
}

output "netbox_domain" {
  value = module.app-infra.netbox_domain
}

output "netbox_host" {
  value = module.app-infra.netbox_host
}

output "vouch_host" {
  value = module.app-infra.vouch_host
}

output "okta_client_id" {
  value = module.okta-netbox-app.client_id
}

output "okta_client_secret" {
  value     = module.okta-netbox-app.client_secret
  sensitive = true
}

output "okta_org_name" {
  value = var.okta_org_name
}

output "okta_base_url" {
  value = var.okta_base_url
}

output "okta_groups" {
  value = module.okta-netbox-app.groups
}

output "okta_superadmins_group" {
  value = one([for groupname in keys(module.okta-netbox-app.groups): groupname if length(regexall("-superadmins", groupname)) > 0])
}

output "okta_admins_group" {
  value = one([for groupname in keys(module.okta-netbox-app.groups): groupname if length(regexall("-admins", groupname)) > 0])
}

output "okta_readonly_group" {
  value = one([for groupname in keys(module.okta-netbox-app.groups): groupname if length(regexall("-readonly", groupname)) > 0])
}

