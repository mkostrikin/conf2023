module "settings" {
  source = "../settings"
}

data "yandex_resourcemanager_cloud" "this" {
  name = module.settings.cloudname
}

data "yandex_resourcemanager_folder" "this" {
  name = module.settings.foldername
}
