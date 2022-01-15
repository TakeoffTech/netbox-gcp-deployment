output "bucket" {
  value = module.bucket.bucket
}

output "redis_host" {
  value = module.memorystore.host
}

output "external_ip" {
  value = google_compute_address.default.address
}

output "netbox_domain" {
  value = length(data.google_dns_managed_zone.netbox_zone[0]) > 0 ? trim(data.google_dns_managed_zone.netbox_zone[0].dns_name, ".") : ""
}

output "netbox_host" {
  value = length(google_dns_record_set.netbox) > 0 ? trim(google_dns_record_set.netbox[0].name, ".") : ""
}

output "vouch_host" {
  value = length(google_dns_record_set.vouch) > 0 ? trim(google_dns_record_set.vouch[0].name, ".") : ""
}