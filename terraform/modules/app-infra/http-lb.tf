resource "google_compute_address" "default" {
  name         = local.name
  description  = "IP used for netbox Load Balancer"
  address_type = "EXTERNAL"
  region       = var.region
}

resource "google_dns_record_set" "netbox" {
  managed_zone = "takeofftech-org"
  project      = "takeoff-dns"
  name         = "${local.name}.takeofftech.org."
  type         = "A"
  rrdatas      = [google_compute_address.default.address]
  ttl          = 300
}

resource "google_dns_record_set" "vouch" {
  managed_zone = "takeofftech-org"
  project      = "takeoff-dns"
  name         = "vouch-${local.name}.takeofftech.org."
  type         = "A"
  rrdatas      = [google_compute_address.default.address]
  ttl          = 300
}