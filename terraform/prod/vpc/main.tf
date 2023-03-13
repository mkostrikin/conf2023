module "values" {
  source = "../values"
}

module "vpc" {
  source = "../../lib/vpc"
  values = module.values.output
}
