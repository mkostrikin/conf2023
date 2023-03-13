output "output" {
  value = merge(
    module.base.output,
    { settings = merge(module.base.output.settings, module.settings) }
  )
}