
module "command_queue" {
  source             = "./command_queues"
  name               = "CQ ${var.identifier}"
  asset_id           = module.satellite_base.satellite.id
  ground_station_ids = var.ground_station_ids
  plugins            = var.plugins
}

module "command_definition" {
  source = "./command_definitions"
  command_definitions = {
    "reinitialize_satellite" : {
      name        = "Reinitialize Satellite"
      description = "Reinitializes the satellite"
      node_id     = module.satellite_base.satellite.id
      arguments = [
        {
          name       = "name"
          identifier = "name"
          attributes = {
            default_value = "restart"
            type          = "TEXT"
            required      = true
          }
        },
        {
          name       = "boolean_value"
          identifier = "boolean_value"
          attributes = {
            default_value = true
            type          = "BOOLEAN"
            required      = true
          }
        }
      ]
    },
    "thruster_control_plus_x" : {
      name        = "Thruster Control Plus X"
      description = "Controls the thruster valves for the plus_x direction."
      node_id     = module.satellite_base.satellite.id
      arguments = [
        {
          name       = "name"
          identifier = "name"
          attributes = {
            default_value = "plus_x_thruster_pos"
            type          = "TEXT"
            required      = true
          }
        },
        {
          name       = "Open Valve"
          identifier = "boolean_value"
          attributes = {
            default_value = true
            type          = "BOOLEAN"
            required      = true
          }
        }
      ]
    },
    "thruster_control_minus_x" : {
      name        = "Thruster Control Minus X"
      description = "Controls the thruster valves for the minus_x direction."
      node_id     = module.satellite_base.satellite.id
      arguments = [
        {
          name       = "name"
          identifier = "name"
          attributes = {
            default_value = "minus_x_thruster_pos"
            type          = "TEXT"
            required      = true
          }
        },
        {
          name       = "Open Valve"
          identifier = "boolean_value"
          attributes = {
            default_value = false
            type          = "BOOLEAN"
            required      = true
          }
        }
      ]
    },
    "capture_image" : {
      name        = "Capture Image"
      description = "This command will task the satellite with taking a photo using the hyperspectral camera payload"
      node_id     = module.satellite_base.satellite.id
      arguments = [
        {
          name       = "name"
          identifier = "name"
          attributes = {
            default_value = "camera_state"
            type          = "TEXT"
            required      = true
          }
        },
        {
          name       = "State"
          identifier = "numeric_value"
          attributes = {
            default_value = 1.0
            type          = "NUMERIC"
            required      = true
          }
        }
      ]
    }
  }
}

module "activity_definitions" {
  source = "./activity_definitions"
  activity_definitions = {
    "Move on positive x axis" : {
      description        = "An activity definition to move the satellite on the x axis"
      node_id            = module.satellite_base.satellite.id
      estimated_duration = 6
      metadata = [
        {
          name = "disabled"
          attributes = {
            type  = "BOOLEAN"
            value = false
          }
        },
        {
          name = "enabled"
          attributes = {
            type  = "BOOLEAN"
            value = true
          }
        }
      ]
      command_mappings = [
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_plus_x.id
          delay_in_milliseconds = 0
          metadata_mappings = [{
            activity_definition_metadata_name = "enabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_plus_x.id
          delay_in_milliseconds = 2000
          metadata_mappings = [{
            activity_definition_metadata_name = "disabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_minus_x.id
          delay_in_milliseconds = 4000
          metadata_mappings = [{
            activity_definition_metadata_name = "enabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_minus_x.id
          delay_in_milliseconds = 6000
          metadata_mappings = [{
            activity_definition_metadata_name = "disabled"
            command_definition_argument_name  = "Open Valve"
          }]
        }
      ]
    },
    "Move on negative x axis" : {
      description        = "An activity definition to move the satellite on the x axis"
      node_id            = module.satellite_base.satellite.id
      estimated_duration = 6
      metadata = [
        {
          name = "disabled"
          attributes = {
            type  = "BOOLEAN"
            value = false
          }
        },
        {
          name = "enabled"
          attributes = {
            type  = "BOOLEAN"
            value = true
          }
        }
      ]
      command_mappings = [
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_minus_x.id
          delay_in_milliseconds = 0
          metadata_mappings = [{
            activity_definition_metadata_name = "enabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_minus_x.id
          delay_in_milliseconds = 2000
          metadata_mappings = [{
            activity_definition_metadata_name = "disabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_plus_x.id
          delay_in_milliseconds = 4000
          metadata_mappings = [{
            activity_definition_metadata_name = "enabled"
            command_definition_argument_name  = "Open Valve"
          }]
        },
        {
          command_definition_id = module.command_definition.command_definition.thruster_control_plus_x.id
          delay_in_milliseconds = 6000
          metadata_mappings = [{
            activity_definition_metadata_name = "disabled"
            command_definition_argument_name  = "Open Valve"
          }]
        }
      ]
    }
  }
}
