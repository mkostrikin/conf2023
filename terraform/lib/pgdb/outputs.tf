output "output" {
  value = {
    db   = yandex_mdb_postgresql_database.this
    user = yandex_mdb_postgresql_user.this
  }
}