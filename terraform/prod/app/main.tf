module "values" {
  source = "../values"
}

module "vpc" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "vpc"
}

module "pgdb" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "pgdb"
}

module "app" {
  source = "../../lib/instance-group"
  values = merge(module.values.output,
    { pgdb = module.pgdb.output
  vpc = module.vpc.output })
}
