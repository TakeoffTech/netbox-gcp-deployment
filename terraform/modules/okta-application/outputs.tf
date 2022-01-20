output "client_id" {
  value = length(okta_app_oauth.netbox) > 0 ? okta_app_oauth.netbox[0].client_id : ""
}

output "client_secret" {
  value     = length(okta_app_oauth.netbox) > 0 ? okta_app_oauth.netbox[0].client_secret : ""
  sensitive = true
}

output "org_name" {
  value = var.org_name
}

output "base_url" {
  value = var.base_url
}