module "values" {
  source = "../values"
}

module "vpc" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "vpc"
}

module "dns" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "dns"
}

module "app" {
  source    = "../../lib/get_remote_data"
  values    = module.values.output
  env       = "prod"
  component = "app"
}

module "alb" {
  source = "../../lib/alb"
  values = merge(
    module.values.output,
    { vpc = module.vpc.output }
  )
}

module "vlb" {
  source = "../../lib/vlb"
  values = merge(module.values.output,
    { alb = module.alb.output
      dns = module.dns.output
      app = module.app.output
  })
}
