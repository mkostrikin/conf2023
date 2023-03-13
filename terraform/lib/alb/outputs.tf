output "output" {
  value = merge(yandex_alb_load_balancer.this, { http_router = yandex_alb_http_router.this })
}
