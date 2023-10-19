terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_plugins" "command_transformer" {
  name                      = "LeanspaceSatelliteCommandTransformerFromTerraform"
  type                      = "COMMANDS_COMMAND_TRANSFORMER_PLUGIN_TYPE"
  file_path                 = "${path.module}/satellite-command-transformer-plugin.jar"
  implementation_class_name = "io.leanspace.plugins.commands.LeanspaceSatelliteCommandTransformer"
  sdk_version               = "2.1.1"
}


output "command_transformer_id" {
  value = leanspace_plugins.command_transformer.id
}
