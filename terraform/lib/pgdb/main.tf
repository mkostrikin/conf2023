resource "yandex_mdb_postgresql_database" "this" {
  cluster_id = var.values.pgdb.id
  name       = "db-${var.values.settings.env}"
  owner      = yandex_mdb_postgresql_user.this.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
  extension {
    name = "uuid-ossp"
  }
  extension {
    name = "xml2"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "yandex_mdb_postgresql_user" "this" {
  cluster_id = var.values.pgdb.id
  conn_limit = 10
  name       = "user-${var.values.settings.env}"
  password   = random_password.password.result
}
