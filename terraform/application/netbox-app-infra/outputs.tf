output "bucket" {
  value = module.app-infra.bucket
}

output "redis_host" {
  value = module.app-infra.redis_host
}

output "external_ip" {
  value = module.app-infra.external_ip
}
