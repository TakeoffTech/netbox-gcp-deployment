output "bucket" {
  value = module.bucket.bucket
}

output "redis_host" {
  value = module.memorystore.host
}
