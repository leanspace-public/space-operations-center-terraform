terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}



locals {
  routeInformations = [
    for info in var.ground_station_informations : {
      groundStationId = info.id
      routeNameList   = [ "${info.name} - ${var.satellite_name} - TC", "${var.satellite_name} - TM" ]
    }
  ]
}
resource "leanspace_release_queues" "release_queue" {
  name                           = var.name
  asset_id                       = var.asset_id
  command_transformer_plugin_id  = var.plugin
  command_transformation_strategy = "USE_PLUGIN"

  dynamic "global_transmission_metadata" {
    for_each = var.ccsds_parameter

    content {
      key   = global_transmission_metadata.key
      value = tostring(global_transmission_metadata.value)
    }
  }

  global_transmission_metadata {
    key   = "routeInformations"
    value = jsonencode({routeInformations = local.routeInformations })
  }


}

output "release_queue" {
  value = leanspace_release_queues.release_queue
}
