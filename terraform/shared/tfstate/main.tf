module "values" {
  source = "../values"
}

module "tfstate-storage" {
  source = "../../lib/tfstate"
  values = module.values.output
}

module "terraform-lock" {
  source = "../../lib/tflock"
  values = module.values.output
}
