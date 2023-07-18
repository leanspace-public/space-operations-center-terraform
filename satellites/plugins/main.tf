terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_plugins" "command_transformer" {
  name                      = "LeanspaceSatelliteCommandTransformer test"
  type                      = "COMMANDS_COMMAND_TRANSFORMER_PLUGIN_TYPE"
  file_path                 = "${path.module}/satellite-command-transformer-plugin.jar"
  implementation_class_name = "io.leanspace.plugins.commands.LeanspaceSatelliteCommandTransformer"
  sdk_version               = "2.1.1"
}

resource "leanspace_plugins" "protocol_transformer" {
  name                      = "Generic CCSDS Protocol Transformer test"
  type                      = "COMMANDS_PROTOCOL_TRANSFORMER_PLUGIN_TYPE"
  file_path                 = "${path.module}/generic-ccsds-protocol-transformer-plugin.jar"
  implementation_class_name = "io.leanspace.plugins.protocol.GenericCcsdsProtocolTransformer"
  sdk_version               = "2.1.1"
}

output "command_transformer_id" {
  value = leanspace_plugins.command_transformer.id
}

output "protocol_transformer_id" {
  value = leanspace_plugins.protocol_transformer.id
}
