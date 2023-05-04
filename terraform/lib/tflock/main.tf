resource "yandex_ydb_database_serverless" "this" {
  name      = "terraform-lock-ydb-serverless"
  folder_id = var.values.yandexcloud.folder_id

  deletion_protection = true
  location_id         = "ru-central1"
}

resource "yandex_ydb_table" "this" {
  path              = var.values.settings.tfstate.locks
  connection_string = resource.yandex_ydb_database_serverless.this.ydb_full_endpoint

  column {
    name     = "__Hash"
    type     = "Uint64"
    not_null = false
  }

  column {
    name     = "LockID"
    type     = "Utf8"
    not_null = false
  }

  column {
    name     = "__RowData"
    type     = "JsonDocument"
    not_null = false
  }

  primary_key = [
    "__Hash", "LockID"
  ]
}
