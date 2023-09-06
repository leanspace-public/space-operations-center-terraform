terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_routes" "route" {
  name = var.name
  definition {
    configuration= format("- beans:\r\n    - name: ccssdsProcessor\r\n      type: io.leanspace.routes.processors.ccsdsprocessor.protocol.CcsdsProtocolTransformerProcessor(\"%s\", \"%s\", \"%s\")\r\n    - name: byteArrayEncoder\r\n      type: io.leanspace.routes.helper.ByteArrayEncoderUDP\r\n- route:\r\n    from:\r\n      uri: \"leanspace-command:\"\r\n      parameters:\r\n        tenant: '%s'\r\n        clientId: '%s'\r\n        clientSecret: '%s'\r\n        releaseQueueId: '%s'\r\n        maxNumberOfCommands: %s\r\n        delay: 2\r\n        initialDelay: 2\r\n        timeUnit: SECONDS\r\n        ignoreInterruptedException: true\r\n      steps:\r\n              - process:\r\n                  ref: \"ccssdsProcessor\"\r\n              - log:\r\n                  message: \"body: $${in.body}\"\r\n              - convertBodyTo:\r\n                  type: byte[]\r\n              - to:\r\n                  uri: \"netty:udp://%s:%s\"\r\n                  parameters:\r\n                    encoders: \"#byteArrayEncoder\"\r\n                    sync: false\r\n                    requestTimeout: 30000", var.tenant, var.client_id_ccs_protocol_transformer, var.client_secret_ccs_protocol_transformer, var.tenant, var.client_id_command_connector, var.client_secret_command_connector, var.release_queue_id, var.number_commmand_pull_command_connector, var.ground_stations.adress, var.ground_stations.port)
    log_level = "INFO"
    service_account_id = var.route_service_account_id
  }

  tags {
    key   = "type-connection"
    value = "TC"
  }
  tags {
    key  = "groundStation"
    value = var.ground_stations.name
  }
}
data "leanspace_nodes" "ground_stations" {
  filters {
    query = var.ground_stations.name
  }
}
data "leanspace_release_queues" "release_queue" {
  filters {
    ids = [var.release_queue_id]
  }
}
