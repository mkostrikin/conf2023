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
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "test"
  component = "app"
}

module "vlb" {
  source = "../../lib/vlb"
  values = merge(module.values.output,
    { pgdb = module.pgdb.output
      app  = module.app.output
  })
}
