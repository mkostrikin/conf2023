module "settings" {
  source = "../settings"
}

module "shared" {
  source = "../../shared/values"
}

module "base" {
  source    = "../../lib/get_remote_data"
  values    = module.shared.output
  env       = "shared"
  component = "base"
}
