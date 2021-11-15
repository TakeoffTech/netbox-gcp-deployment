data "google_sql_database_instance" "default" {
  name = var.cloudsql_instance_name
}

resource "kubernetes_secret" "cloudsql-instance-name" {
  metadata {
    name      = "cloudsql-instance"
    namespace = var.namespace
  }

  data = {
    "name"            = data.google_sql_database_instance.default.name
    "connection_name" = data.google_sql_database_instance.default.connection_name
    "region"          = data.google_sql_database_instance.default.region
    "version"         = data.google_sql_database_instance.default.database_version
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "cloudsql_instance_info" {
  metadata {
    name      = "cloudsql-instance-info"
    namespace = var.namespace
  }

  data = {
    "name"            = data.google_sql_database_instance.default.name
    "connection_name" = data.google_sql_database_instance.default.connection_name
    "region"          = data.google_sql_database_instance.default.region
    "version"         = data.google_sql_database_instance.default.database_version
  }
}
