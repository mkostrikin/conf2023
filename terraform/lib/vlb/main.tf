locals {
  host = "${var.values.settings.env}.${var.values.settings.dns.zonename}"
}

resource "yandex_alb_virtual_host" "this" {
  name           = "virtual-host-${var.values.settings.env}"
  authority      = [trim(local.host, ".")]
  http_router_id = var.values.alb.http_router.id

  route {
    name = "route-${var.values.settings.env}"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout          = "3s"
      }
      http_match {
        http_method = []
        path {
          prefix = "/"
        }
      }

    }
  }
}

resource "yandex_alb_backend_group" "this" {
  name      = "app-backend-group-${var.values.settings.env}"
  folder_id = var.values.yandexcloud.folder_id

  http_backend {
    name             = "app-http-backend-${var.values.settings.env}"
    weight           = 1
    port             = 80
    target_group_ids = [var.values.app.application_load_balancer[0].target_group_id]

    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1m0s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_dns_recordset" "cname" {
  zone_id = var.values.dns.id
  name    = local.host
  type    = "A"
  data    = [var.values.alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
  ttl     = 60
}
