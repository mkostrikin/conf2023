resource "yandex_vpc_network" "this" {
  name      = var.values.settings.vpc.name
  folder_id = var.values.yandexcloud.folder_id

}

resource "yandex_vpc_subnet" "this-subnet-a" {
  v4_cidr_blocks = [var.values.settings.vpc.cidr_a]
  zone           = "ru-central1-a"
  name           = "poc-subnet-a"
  network_id     = yandex_vpc_network.this.id
  folder_id      = var.values.yandexcloud.folder_id

}

resource "yandex_vpc_subnet" "this-subnet-b" {
  v4_cidr_blocks = [var.values.settings.vpc.cidr_b]
  zone           = "ru-central1-b"
  name           = "poc-subnet-b"
  network_id     = yandex_vpc_network.this.id
  folder_id      = var.values.yandexcloud.folder_id
}

resource "yandex_vpc_subnet" "this-subnet-c" {
  v4_cidr_blocks = [var.values.settings.vpc.cidr_c]
  zone           = "ru-central1-c"
  name           = "poc-subnet-c"
  network_id     = yandex_vpc_network.this.id
  folder_id      = var.values.yandexcloud.folder_id
}

