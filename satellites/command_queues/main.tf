terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_command_queues" "command_queue" {
  name                           = var.name
  asset_id                       = var.asset_id
  ground_station_ids             = var.ground_station_ids
  command_transformer_plugin_id  = var.plugins[0]
  protocol_transformer_plugin_id = var.plugins[1]
  protocol_transformer_init_data = jsonencode({
    "defaultPacketSequenceNumber" : 1,
    "defaultVirtualChannelSequenceNumbers" : {
      "1" : 1
    },
    "defaultMetadataValues" : {
      "TC_PACKET_HEADER_VERSION" : 7,
      "TC_FRAME_HEADER_CONTROL_FLAG" : 1,
      "TC_PACKET_HEADER_TYPE" : 1,
      "TC_FRAME_HEADER_VERSION" : 3,
      "TC_FRAME_HEADER_BYPASS_FLAG" : 1,
      "TC_PACKET_HEADER_SEQUENCE_FLAG" : 3,
      "TC_SEGMENT_HEADER_MAP_ID" : 63,
      "TC_FRAME_HEADER_SPACECRAFT_ID" : 749,
      "TC_PACKET_HEADER_DFH_FLAG" : 1,
      "TC_FRAME_HEADER_VIRTUAL_CHANNEL" : 2,
      "TC_PACKET_HEADER_AP_ID" : 2047
    }
  })
}

output "command_queue" {
  value = leanspace_command_queues.command_queue
}
