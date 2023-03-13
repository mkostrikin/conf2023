module "values" {
  source = "../values"
}

module "pgdb" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "test"
  component = "pgdb"
}

module "app" {
  source = "../../lib/instance-group"
  values = merge(module.values.output,
  { pgdb = merge(module.values.output.pgdb, module.pgdb.output) })
}
