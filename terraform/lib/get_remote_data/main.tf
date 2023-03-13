data "terraform_remote_state" "this" {
  backend = "s3"

  config = {
    endpoint = "storage.yandexcloud.net"
    bucket   = var.values.settings.tfstate.bucket
    key      = "${var.env}/${var.component}/terraform.tfstate"
    region   = var.values.settings.tfstate.region

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
