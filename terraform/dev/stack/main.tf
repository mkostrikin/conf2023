module "values" {
  source = "../values"
}

module "pgdb" {
  source = "../../lib/pgdb"
  values = module.values.output
}

module "app" {
  source = "../../lib/instance-group"
  values = merge(module.values.output,
  { pgdb = merge(module.values.output.pgdb, module.pgdb.output) })
}

module "vlb" {
  source = "../../lib/vlb"
  values = merge(module.values.output,
    { pgdb = module.pgdb.output
      app  = module.app.output
  })
}
