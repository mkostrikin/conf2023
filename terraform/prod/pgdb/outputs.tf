output "output" {
  value     = merge(module.pgcluster.output, module.pgdb.output)
  sensitive = true
}
