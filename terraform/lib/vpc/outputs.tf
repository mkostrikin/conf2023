output "output" {
  value = merge(yandex_vpc_network.this,
    { default_subnet = yandex_vpc_subnet.this-subnet-a,
      default_zone   = "ru-central1-a"
    }
  )
}
