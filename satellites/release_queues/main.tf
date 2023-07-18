terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_release_queues" "release_queue" {
  name                           = var.name
  asset_id                       = var.asset_id
  command_transformer_plugin_id  = var.plugin
  command_transformation_strategy = "USE_PLUGIN"
}

output "release_queue" {
  value = leanspace_release_queues.release_queue
}
