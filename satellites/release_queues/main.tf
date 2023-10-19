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
      groundStationId = "GROUND_STATION_ID_${info.id}"
      routeNameList   = "[\"${info.name} - ${var.satellite_name} - TC\"]"
    }
  ]
}
resource "leanspace_release_queues" "release_queue" {
  name                            = var.name
  asset_id                        = var.asset_id
  command_transformer_plugin_id   = var.plugin
  command_transformation_strategy = "USE_PLUGIN"

  dynamic "global_transmission_metadata" {
    for_each = var.ccsds_parameter

    content {
      key   = global_transmission_metadata.key
      value = tostring(global_transmission_metadata.value)
    }
  }
  dynamic "global_transmission_metadata" {
    for_each = { for info in local.routeInformations : info.groundStationId => info.routeNameList }
    content {
      key   = global_transmission_metadata.key
      value = tostring(global_transmission_metadata.value)
    }
  }
}

output "release_queue" {
  value = leanspace_release_queues.release_queue
}
