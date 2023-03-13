output "output" {
  value = {
    settings = module.settings
    yandexcloud = {
      cloud_id  = data.yandex_resourcemanager_cloud.this.cloud_id
      folder_id = data.yandex_resourcemanager_folder.this.folder_id
    }
  }
}