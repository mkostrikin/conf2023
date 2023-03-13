resource "yandex_dns_zone" "this" {
  name = var.values.settings.dns.resourcename

  labels    = var.values.settings.dns.labels
  folder_id = var.values.yandexcloud.folder_id

  zone             = var.values.settings.dns.zonename
  public           = true
  private_networks = [var.values.vpc.id]
}
