terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_activity_definitions" "activity_definition" {
  for_each = var.activity_definitions

  name               = each.key
  description        = each.value.description
  node_id            = each.value.node_id
  estimated_duration = each.value.estimated_duration
  dynamic "metadata" {
    for_each = each.value.metadata
    content {
      name = metadata.value.name
      attributes {
        value = metadata.value.attributes.value
        type  = metadata.value.attributes.type
      }
    }
  }
  dynamic "command_mappings" {
    for_each = each.value.command_mappings != null ? each.value.command_mappings : []
    content {
      command_definition_id = command_mappings.value.command_definition_id
      delay_in_milliseconds = command_mappings.value.delay_in_milliseconds
      dynamic "metadata_mappings" {
        for_each = command_mappings.value.metadata_mappings != null ? command_mappings.value.metadata_mappings : []
        content {
          activity_definition_metadata_name = metadata_mappings.value.activity_definition_metadata_name
          command_definition_argument_name  = metadata_mappings.value.command_definition_argument_name
        }
      }
    }
  }

}
