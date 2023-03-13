module "values" {
  source = "../values"
}

module "vhost" {
  source = "../../lib/vhost"
  values = module.values.output
}
