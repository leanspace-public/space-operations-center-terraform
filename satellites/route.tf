module "route" {
  source = "./routes"
  tenant = var.route_tenant
  release_queue_id = module.release_queues.release_queue.id
  client_id = var.route_client_id
  client_secret = var.route_client_secret
  name = "route ${var.identifier}"
}