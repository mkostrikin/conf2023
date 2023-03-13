output "tfstate" {
  value = {
    bucket = var.bucket_name
    locks  = var.locks
    region = "ru-central-1"
  }
}

output "environment" {
  value = "shared"
}

output "env" {
  value = "shrd"
}

output "cloudname" {
  value = "cloud-mkostrikin"
}

output "foldername" {
  value = "poc"
}

output "vpc" {
  value = {
    name   = "poc-network"
    cidr_a = "10.2.0.0/16"
    cidr_b = "10.3.0.0/16"
    cidr_c = "10.4.0.0/16"
  }
}

output "dns" {
  value = {
    zonename     = "v7w.ru." # zone name must ends with '.'
    resourcename = "poc-public-zone"
    labels       = { "label1" = "label-1-value" }
  }
}

output "db" {
  value = {
    disk_size = 10
  }
}
