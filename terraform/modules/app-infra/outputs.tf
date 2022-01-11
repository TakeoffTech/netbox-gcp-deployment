output "bucket" {
  value = module.bucket.bucket
}

output "redis_host" {
  value = module.memorystore.host
}

output "external_ip" {
  value = google_compute_address.default.address
}
