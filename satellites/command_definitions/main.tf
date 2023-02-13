terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_command_definitions" "command_definition" {
  for_each = var.command_definitions

  name        = each.value.name
  description = each.value.description
  node_id     = each.value.node_id
  dynamic "arguments" {
    for_each = each.value.arguments
    content {
      name       = arguments.value.name
      identifier = arguments.value.identifier
      attributes {
        default_value = arguments.value.attributes.default_value
        type          = arguments.value.attributes.type
        required      = arguments.value.attributes.required
      }
    }
  }
}

output "command_definition" {
  value = leanspace_command_definitions.command_definition
}
