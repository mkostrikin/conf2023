module "values" {
  source = "../values"
}

module "dns" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "shared"
  component = "base"
}
