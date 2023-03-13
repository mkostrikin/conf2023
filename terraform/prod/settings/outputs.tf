output "tfstate" {
  value = {
    bucket = var.bucket_name
    locks  = var.locks
    region = "ru-central-1"
  }
}

output "environment" {
  value = "Production"
}

output "env" {
  value = "prod"
}

output "cloudname" {
  value = "cloud-mkostrikin"
}

output "foldername" {
  value = "poc-prod"
}

output "vpc" {
  value = {
    name   = "poc-prod-network"
    cidr_a = "10.8.0.0/16"
    cidr_b = "10.9.0.0/16"
    cidr_c = "10.10.0.0/16"
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
