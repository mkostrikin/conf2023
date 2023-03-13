module "values" {
  source = "../values"
}

module "pgdb" {
  source = "../../lib/pgdb"
  values = module.values.output
}
