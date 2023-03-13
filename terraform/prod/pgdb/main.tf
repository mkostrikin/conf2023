module "values" {
  source = "../values"
}

module "pgcluster" {
  source = "../../lib/pgcluster"
  values = merge(
    module.values.output,
    { vpc = module.vpc.output }
  )
}

module "pgdb" {
  source = "../../lib/pgdb"
  values = merge(
    module.values.output,
    { pgdb = module.pgcluster.output }
  )
}

module "vpc" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "vpc"
}
