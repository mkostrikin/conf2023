resource "yandex_alb_load_balancer" "this" {
  name = "load-balancer-${var.values.settings.env}"

  network_id = var.values.vpc.id
  folder_id  = var.values.yandexcloud.folder_id

  allocation_policy {
    location {
      zone_id   = var.values.vpc.default_zone
      subnet_id = var.values.vpc.default_subnet.id
    }
  }

  listener {
    name = "listener-${var.values.settings.env}"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_ALL"]
      discard_percent     = 99
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name      = "http-router-${var.values.settings.env}"
  folder_id = var.values.yandexcloud.folder_id
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}
