resource "yandex_mdb_postgresql_cluster" "this" {
  name        = "pg-${var.values.settings.env}"
  environment = "PRESTABLE"
  network_id  = var.values.vpc.id
  folder_id   = var.values.yandexcloud.folder_id

  config {
    version = 14
    resources {
      resource_preset_id = "b2.nano"
      disk_type_id       = "network-hdd"
      disk_size          = var.values.settings.db.disk_size
    }
  }

  host {
    zone      = var.values.vpc.default_zone
    subnet_id = var.values.vpc.default_subnet.id
  }
}