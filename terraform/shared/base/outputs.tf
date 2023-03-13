output "output" {
  value = merge(
    module.values.output,
    {
      vpc  = module.vpc.output,
      dns  = module.dns.output,
      alb  = module.alb.output,
      pgdb = module.pgcluster.output,
  })
}
