resource "random_password" "password" {
  length           = 20
  special          = true
}

output "password" {
  value = random_password.password.result
  sensitive = true
}

output "sha1_password" {
  value = sha1("${random_password.password.result}")
  sensitive = true
}