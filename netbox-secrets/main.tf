resource "random_password" "password" {
  length  = 20
  special = true
}

resource "random_password" "jwt_secret" {
  length  = 44
  special = false
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}

output "sha1_password" {
  value     = sha1("${random_password.password.result}")
  sensitive = true
}

output "jwt_secret" {
  value     = random_password.jwt_secret.result
  sensitive = true
}