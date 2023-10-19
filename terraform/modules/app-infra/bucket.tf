resource "random_id" "suffix" {
  count = var.random_bucket_name ? 1 : 0

  byte_length = 4
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 5.0"

  name               = "${local.name}-media-${random_id.suffix[0].hex}"
  project_id         = var.project_id
  location           = "US"
  bucket_policy_only = false
  force_destroy      = var.bucket_force_destroy

  iam_members = [{
    role   = "roles/storage.admin"
    member = "serviceAccount:${local.name}@${var.project_id}.iam.gserviceaccount.com"
  }]
  depends_on = [
    module.my-app-workload-identity
  ]
}
