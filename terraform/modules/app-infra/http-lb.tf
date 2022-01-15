resource "google_compute_address" "default" {
  name         = local.name
  description  = "IP used for netbox Load Balancer"
  address_type = "EXTERNAL"
  region       = var.region
}

locals {
  create_dns_records = length(var.managed_zone) > 0

  dns_name = length(data.google_dns_managed_zone.netbox_zone[0]) > 0 ? data.google_dns_managed_zone.netbox_zone[0].dns_name : ""

  name_same_as_zone = length(regexall("${var.namespace}.", local.dns_name)) > 0

  netbox_host = local.name_same_as_zone ? local.dns_name : "${var.namespace}.${local.dns_name}"
  vouch_host  = local.name_same_as_zone ? "vouch.${local.netbox_host}" : "vouch-${local.netbox_host}"

  dns_project_id = var.dns_project_id == "" ? var.project_id : var.dns_project_id
}

data "google_dns_managed_zone" "netbox_zone" {
  count   = local.create_dns_records ? 1 : 0
  name    = var.managed_zone
  project = local.dns_project_id
}
resource "google_dns_record_set" "netbox" {
  count        = local.create_dns_records ? 1 : 0
  managed_zone = var.managed_zone
  project      = local.dns_project_id
  name         = local.netbox_host
  type         = "A"
  rrdatas      = [google_compute_address.default.address]
  ttl          = 300
}

resource "google_dns_record_set" "vouch" {
  count        = local.create_dns_records && var.create_vouch_record ? 1 : 0
  managed_zone = var.managed_zone
  project      = local.dns_project_id
  name         = local.vouch_host
  type         = "A"
  rrdatas      = [google_compute_address.default.address]
  ttl          = 300
}