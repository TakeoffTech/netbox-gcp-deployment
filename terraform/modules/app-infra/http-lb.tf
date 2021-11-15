resource "google_compute_global_address" "default" {
  name         = local.name
  description  = "IP used for netbox Load Balancer"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

resource "google_dns_record_set" "default" {
  managed_zone = "takeofftech-org"
  project      = "takeoff-dns"
  name         = "${local.name}.takeofftech.org."
  type         = "A"
  rrdatas      = [google_compute_global_address.default.address]
  ttl          = 300
}