
module "satellite_base" {
  source = "./nodes"

  satellite = {
    parent_node_id = var.parent_node_id
    name           = "${var.identifier}"
    description    = "${var.identifier} is a satellite that carries a hyperspectral camera payload."
    tle = [
      "1 25544U 98067A   20097.18686503  .00000920  00000-0  25115-4 0  9994",
      "2 25544  51.6465 344.7546 0003971  92.6495  47.0504 15.48684294220855"
    ]
    tags = {
      "identifier" : var.identifier,
      "soc" : ""
    }
  }

  properties = {
    "Cost" : { value = 285850 }
    "Mass" : { value = 490 }
  }
  metrics = {
    "altitude" : {
      type = "NUMERIC"
      tags = {
        "soc" : ""
        "soc-elevation" : ""
      }
    }
    "latitude" : {
      type = "NUMERIC"
      tags = {
        "soc-latitude" : "",
        "soc-key-metric" : ""
      }
    }
    "longitude" : {
      type = "NUMERIC"
      tags = {
        "soc-longitude" : ""
      }
    }
    "eclipse" : {
      type = "BOOLEAN"
      tags = {
        "soc" : "",
        "soc-icon" : "Brightness3"
      }
    }
    "orbital_period" : {
      type = "NUMERIC"
    }
    "bus_current" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-icon" : "ElectricMeter",
        "soc-key-metric" : ""
      }
    }
    "bus_voltage" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-icon" : "ElectricBolt",
        "soc-key-metric" : ""
      }
    }
    "sc_alt" : {
      type = "NUMERIC"
    }
    "sc_dry_mass" : {
      type = "NUMERIC"
    }
    "sc_pitch" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-large-metric" : ""
      }
    }
    "sc_roll" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-large-metric" : ""
      }
    }
    "sc_velocity" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-large-metric" : "",
        "soc-key-metric" : ""
      }
    }
    "sc_wet_mass" : {
      type = "NUMERIC"
    }
    "sc_yaw" : {
      type = "NUMERIC"
      tags = {
        "soc" : "",
        "soc-large-metric" : ""
      }
    }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "aocs" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "AOCS"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 59550 },
    "Mass" : { value = 54 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "reaction_wheels" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.aocs.satellite.id
    name           = "ReactionWheels"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 21600 },
    "Mass" : { value = 30 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "reaction_wheels_sub" {
  source   = "./nodes"
  for_each = toset(["1", "2", "3"])

  satellite = {
    parent_node_id = module.reaction_wheels.satellite.id
    name           = "ReactionWheel${each.value}"
    type           = "COMPONENT"
  }
  metrics = {
    "Reaction wheel ${each.value}" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 7200 },
    "Mass" : { value = 10 },
    "torque" : { value = 0 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "sun_sensors" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.aocs.satellite.id
    name           = "SunSensors"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 37950 },
    "Mass" : { value = 24 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "sun_sensors_sub" {
  source   = "./nodes"
  for_each = toset(["X", "Y", "Z"])

  satellite = {
    parent_node_id = module.sun_sensors.satellite.id
    name           = "SunSensor${each.value}"
    type           = "COMPONENT"
  }
  metrics = {
    "Sun Sensor ${each.value}" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 21650 },
    "Mass" : { value = 8 },
    "sun_sensor_${lower(each.value)}_lower" : { value = 0 },
    "sun_sensor_${lower(each.value)}_upper" : { value = 0 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "eps" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "EPS"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 96500 },
    "Mass" : { value = 265 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "battery" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.eps.satellite.id
    name           = "Battery"
    type           = "COMPONENT"
  }
  metrics = {
    "Depth of Discharge" : { type = "NUMERIC" }
    "Energy" : { type = "NUMERIC" }
    "Temperature" : { type = "NUMERIC" }
    "Total Power Output" : { type = "NUMERIC" }
    "Total Power Input" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 52500 },
    "Mass" : { value = 215 },
    "battery_temp_lower" : { value = -10 },
    "battery_temp_upper" : { value = 45 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "solar_arrays" {
  source   = "./nodes"
  for_each = { "North" : "plus_y", "South" : "minus_y" }

  satellite = {
    parent_node_id = module.eps.satellite.id
    name           = "SolarArray${each.key}"
    type           = "COMPONENT"
  }
  metrics = {
    "Current" : { type = "NUMERIC" }
    "Temperature" : { type = "NUMERIC" }
    "Voltage" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 22000 },
    "Mass" : { value = 25 },
    "sa_${each.value}_current_lower" : { value = 29 },
    "sa_${each.value}_current_upper" : { value = 30 },
    "sa_${each.value}_temp_lower" : { value = -70 },
    "sa_${each.value}_temp_upper" : { value = 75 },
    "sa_${each.value}_voltage_lower" : { value = 140 },
    "sa_${each.value}_voltage_upper" : { value = 150 },
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}


module "obc" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "OBC"
    type           = "COMPONENT"
  }
  metrics = {
    "CPU Usage" : { type = "NUMERIC" }
    "Persistent Memory Usage" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 12650 },
    "Mass" : { value = 55 },
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "payload" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "Payload"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 9650 },
    "Mass" : { value = 45 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "camera" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.payload.satellite.id
    name           = "Camera"
    type           = "COMPONENT"
  }
  metrics = {
    "Camera_Power" : { type = "NUMERIC" }
    "Camera_State" : { type = "TEXT" }
  }
  properties = {
    "Cost" : { value = 9650 },
    "Mass" : { value = 45 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "propulsion" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "Propulsion"
    type           = "COMPONENT"
  }
  metrics = {
    "Propellant Level" : { type = "NUMERIC" }
    "Propellant Mass" : { type = "NUMERIC" }
    "Propellant Pressure" : { type = "NUMERIC" }
    "Propellant Temperature" : { type = "NUMERIC" }
  }
  properties = {
    "Cost" : { value = 45000 },
    "Mass" : { value = 22 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "thrusters" {
  source   = "./nodes"
  for_each = toset(["MinusX", "PlusX"])

  satellite = {
    parent_node_id = module.propulsion.satellite.id
    name           = "Thruster${each.value}"
    type           = "COMPONENT"
  }
  metrics = {
    "ExhaustVelocity${each.value}" : { type = "NUMERIC" }
    "MassFlowRate${each.value}" : { type = "NUMERIC" }
    "NozzleTemperature${each.value}" : { type = "NUMERIC" }
    "ValvePosition${each.value}" : { type = "BOOLEAN" }
  }
  properties = {
    "Cost" : { value = 22500 },
    "Mass" : { value = 11 },
    "Max_Temp_Nozzle" : { value = 220 },
    "minus_x_exhaust_velocity_lower" : { value = 0 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}


module "ttc" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.satellite_base.satellite.id
    name           = "TTC"
    type           = "COMPONENT"
  }
  properties = {
    "Cost" : { value = 62500 },
    "Mass" : { value = 49 }
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}

module "rf_power_amplifier" {
  source = "./nodes"

  satellite = {
    parent_node_id = module.ttc.satellite.id
    name           = "RFPowerAmplifier"
    type           = "COMPONENT"
  }
  metrics = {
    "Forward Power" : { type = "NUMERIC" }
    "Reverse Power" : { type = "NUMERIC" }
    "Temperature" : { type = "NUMERIC" }
  }
  properties = {
    "Mass" : { value = 49 },
    "rev_power_lower" : { value = 0 },
    "rev_power_upper" : { value = 0 },
    "fwd_power_lower" : { value = 0 },
    "fwd_power_upper" : { value = 0 },
  }
  sub_tags = { "satellite" : "${var.identifier}" }
}
