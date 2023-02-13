terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

variable "name" {
  type = string
}

variable "streams" {
  type = map(object({
    gateway_id       = string
    stream_id        = string
    command_queue_id = string
    inbound_port     = number
    outbound_port    = number
    host             = string
  }))
}

resource "leanspace_remote_agents" "agent" {
  name = var.name

  dynamic "connectors" {
    for_each = var.streams
    content {
      gateway_id = connectors.value.gateway_id
      type       = "INBOUND"
      stream_id  = connectors.value.stream_id
      socket {
        type = "UDP"
        port = connectors.value.inbound_port
      }
    }
  }
  dynamic "connectors" {
    for_each = var.streams
    content {
      gateway_id       = connectors.value.gateway_id
      type             = "OUTBOUND"
      command_queue_id = connectors.value.command_queue_id
      socket {
        type = "UDP"
        host = connectors.value.host
        port = connectors.value.outbound_port
      }
    }
  }
}
