module "values" {
  source = "../values"
}

module "vpc" {
  source = "../../lib/vpc"
  values = module.values.output
}

module "dns" {
  source = "../../lib/clouddns"
  values = merge(
    module.values.output,
    { vpc = module.vpc.output }
  )
}

module "pgcluster" {
  source = "../../lib/pgcluster"
  values = merge(
    module.values.output,
    { vpc = module.vpc.output }
  )
}

module "alb" {
  source = "../../lib/alb"
  values = merge(
    module.values.output,
    { vpc = module.vpc.output }
  )
}
