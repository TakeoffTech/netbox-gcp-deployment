resource "google_sql_database" "netbox" {
  name       = local.name
  project    = var.project_id
  instance   = data.google_sql_database_instance.default.name
}

resource "random_id" "user-password" {
  keepers = {
    name = data.google_sql_database_instance.default.name
  }

  byte_length = 8
}

resource "google_sql_user" "netbox" {
  name       = local.name
  project    = var.project_id
  instance   = data.google_sql_database_instance.default.name
  password   = random_id.user-password.hex
  depends_on = [
    google_sql_database.netbox
  ]
}

resource "kubernetes_secret" "psql-netbox-user" {
  metadata {
    name      = "psql-netbox-user"
    namespace = var.namespace
  }

  data = {
    "postgresql-username" = local.name
    "postgresql-password" = random_id.user-password.hex
  }

  type = "Opaque"
}
