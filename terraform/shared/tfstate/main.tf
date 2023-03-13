module "values" {
  source = "../values"
}

module "tfstate-storage" {
  source = "../../lib/tfstate"
  values = module.values.output
}
