terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

module "route_release_queue_configuration" {
  for_each = {for ground in var.ground_stations : ground.name => ground}
  source = "./route_release_queue_configuration"
  name = " ${each.value.name} - ${var.satellite_name} - TC"
  client_id_ccs_protocol_transformer = var.client_id_ccs_protocol_transformer
  client_id_command_connector = var.client_id_command_connector
  tenant = var.tenant
  ground_stations = each.value
  route_service_account_id = var.route_service_account_id
  number_commmand_pull_command_connector = var.number_commmand_pull_command_connector
  client_secret_command_connector = var.client_secret_command_connector
  client_secret_ccs_protocol_transformer = var.client_secret_ccs_protocol_transformer
  release_queue_id = var.release_queue_id
}


data "leanspace_streams" "tm_stream" {
  filters {
    query = "Stream ${var.satellite_name}"
  }
}

resource "leanspace_routes" "route_tm" {
  name = "${var.satellite_name} - TM"
  definition {
    configuration= format("- beans:\r\n    - name: byteArrayDecoder\r\n      type: io.leanspace.routes.helper.ByteArrayDecoder\r\n- route:\r\n    id: tm\r\n    from:\r\n      uri: \"netty:udp://%s:%s\"\r\n      parameters:\r\n        decoders : '#byteArrayDecoder'\r\n      steps:\r\n        - log:\r\n            message: Processing $${body}\r\n            loggingLevel: INFO\r\n        - to:\r\n            uri: \"leanspace-stream:%s\"\r\n            parameters:\r\n              tenant: \"%s\"\r\n              clientId: \"%s\"\r\n              clientSecret: \"%s\"", var.server_udp_adress_tm, var.server_udp_port_tm, data.leanspace_streams.tm_stream.content[0].id, var.tenant, var.client_id_stream_route, var.client_secret_stream_route)
    log_level = "INFO"
    service_account_id = var.route_service_account_id
  }

  tags {
    key   = "type-connection"
    value = "RC"
  }
  tags {
    key  = "satellite-name"
    value = var.satellite_name
  }
  tags {
    key  = "stream-id"
    value = data.leanspace_streams.tm_stream.content[0].id
  }
}
output "route_tc" {
  value = module.route_release_queue_configuration
}

output "route_tm" {
  value = leanspace_routes.route_tm
}
