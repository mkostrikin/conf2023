resource "yandex_iam_service_account" "ig-sa" {
  name      = "ig-sa-${var.values.settings.env}"
  folder_id = var.values.yandexcloud.folder_id

  description = "service account to manage IG for ${var.values.settings.env}"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.values.yandexcloud.folder_id

  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
  ]
}

resource "yandex_compute_instance_group" "this" {
  name      = "fixed-ig-with-balancer-${var.values.settings.env}"
  folder_id = var.values.yandexcloud.folder_id

  service_account_id = yandex_iam_service_account.ig-sa.id
  instance_template {
    platform_id = "standard-v2"
    resources {
      memory        = 0.5
      cores         = 2
      core_fraction = 5
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8a67rb91j689dqp60h"
        size     = 5
      }
    }

    network_interface {
      network_id = var.values.vpc.id
      subnet_ids = [var.values.vpc.default_subnet.id]
      nat        = true

    }

    metadata = {
      serial-port-enable = 1

      ssh-keys  = "debian:${file("~/.ssh/id_ed25519.pub")}"
      user-data = templatefile("${path.module}/user-data.shtpl", { Environment = var.values.settings.environment, env = var.values.settings.env, pgcreds = "${var.values.pgdb.host[0].fqdn}" })
    }

    scheduling_policy {
      preemptible = true
    }

  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    zones = [var.values.vpc.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name        = "target-group-${var.values.settings.env}"
    target_group_description = "load balancer target group"
  }
}