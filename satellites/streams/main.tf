terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}


resource "leanspace_streams" "stream" {
  asset_id = var.asset_id
  name     = var.name
  configuration {
    endianness = "BE"
    metadata {
      timestamp {
        expression = "(ctx, raw) => ctx['metadata.received_at'];"
      }
    }
    computations {
      dynamic "elements" {
        for_each = var.computations
        content {
          name       = elements.key
          data_type  = elements.value.data_type
          expression = elements.value.expression
        }
      }
    }
    structure {
      elements {
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 2
          }
          name = "priority"
          type = "FIELD"
        }
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 14
          }
          name = "destination"
          type = "FIELD"
        }
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 14
          }
          name = "source"
          type = "FIELD"
        }
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 6
          }
          name = "destination_port"
          type = "FIELD"
        }
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 6
          }
          name = "source_port"
          type = "FIELD"
        }
        elements {
          data_type = "UINTEGER"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 2
          }
          name = "reserved"
          type = "FIELD"
        }
        elements {
          data_type = "BOOLEAN"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 1
          }
          name = "hmac"
          type = "FIELD"
        }
        elements {
          data_type = "BOOLEAN"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 1
          }
          name = "xtea"
          type = "FIELD"
        }
        elements {
          data_type = "BOOLEAN"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 1
          }
          name = "rdp"
          type = "FIELD"
        }
        elements {
          data_type = "BOOLEAN"
          length {
            unit  = "BITS"
            type  = "FIXED"
            value = 1
          }
          name = "crc"
          type = "FIELD"
        }

        name = "header"
        type = "CONTAINER"
      }
      elements {
        elements {
          elements {
            elements {
              data_type = "TEXT"
              length {
                unit  = "BITS"
                type  = "FIXED"
                value = 80
              }
              name = "command_identifier"
              type = "FIELD"
            }
            elements {
              data_type = "UINTEGER"
              length {
                unit  = "BITS"
                type  = "FIXED"
                value = 8
              }
              name = "status_length"
              type = "FIELD"
            }
            elements {
              data_type = "TEXT"
              length {
                unit = "BYTES"
                type = "DYNAMIC"
                path = "structure.payload.source_switch.command_ack.status_length"
              }
              name = "status"
              type = "FIELD"
            }
            elements {
              data_type = "UINTEGER"
              length {
                unit  = "BITS"
                type  = "FIXED"
                value = 16
              }
              name = "error_code"
              type = "FIELD"
            }
            name = "command_ack"
            type = "CONTAINER"
          }
          elements {
            dynamic "elements" {
              for_each = var.fields
              content {
                type      = "FIELD"
                name      = elements.value[0]
                data_type = elements.value[1]
                length {
                  unit = "BITS"
                  type = "FIXED"
                  value = {
                    "INTEGER" : 32,
                    "DECIMAL" : 32,
                    "BOOLEAN" : 8,
                    "TEXT" : 256,
                  }[elements.value[1]]
                }
              }
            }
            name = "realdata"
            type = "CONTAINER"
          }
          expression {
            options {
              component = "structure.payload.source_switch.realdata"
              value {
                data      = 1
                data_type = "UINTEGER"
              }
            }
            options {
              component = "structure.payload.source_switch.command_ack"
              value {
                data      = 0
                data_type = "UINTEGER"
              }
            }
            switch_on = "structure.header.source"
          }
          name = "source_switch"
          type = "SWITCH"
        }
        elements {
          elements {
            name = "crc_absent"
            type = "CONTAINER"
          }
          elements {
            elements {
              data_type = "UINTEGER"
              length {
                unit  = "BITS"
                type  = "FIXED"
                value = 32
              }
              name = "crc_value"
              type = "FIELD"
            }
            name = "crc_container"
            type = "CONTAINER"
          }
          expression {
            options {
              component = "structure.payload.crc_switch.crc_absent"
              value {
                data      = false
                data_type = "BOOLEAN"
              }
            }
            options {
              component = "structure.payload.crc_switch.crc_container"
              value {
                data      = true
                data_type = "BOOLEAN"
              }
            }
            switch_on = "structure.header.crc"
          }
          name = "crc_switch"
          type = "SWITCH"
        }
        elements {
          elements {
            name = "hmac_absent"
            type = "CONTAINER"
          }
          elements {
            elements {
              data_type = "TEXT"
              length {
                unit  = "BITS"
                type  = "FIXED"
                value = 512
              }
              name = "hmac_value"
              type = "FIELD"
            }
            name = "hmac_container"
            type = "CONTAINER"
          }
          expression {
            options {
              component = "structure.payload.hmac_switch.hmac_absent"
              value {
                data      = false
                data_type = "BOOLEAN"
              }
            }
            options {
              component = "structure.payload.hmac_switch.hmac_container"
              value {
                data      = true
                data_type = "BOOLEAN"
              }
            }
            switch_on = "structure.header.hmac"
          }
          name = "hmac_switch"
          type = "SWITCH"
        }
        name = "payload"
        type = "CONTAINER"
      }
    }
  }
  dynamic "mappings" {
    for_each = var.mappings
    content {
      expression = "$.structure.payload.source_switch.realdata.${mappings.value[0]}"
      metric_id  = mappings.value[1]
    }
  }
  dynamic "mappings" {
    for_each = var.computation_mappings
    content {
      expression = "$.computations.${mappings.value[0]}"
      metric_id  = mappings.value[1]
    }
  }
}

output "stream" {
  value = leanspace_streams.stream
}
