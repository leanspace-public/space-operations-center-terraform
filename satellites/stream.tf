
module "stream" {
  source   = "./streams"
  asset_id = module.satellite_base.satellite.id
  name     = "Stream ${var.identifier}"

  fields = [
    ["orbital_period", "DECIMAL"],
    ["eclipse", "BOOLEAN"],
    ["sa_plus_y_voltage", "DECIMAL"],
    ["sa_plus_y_current", "DECIMAL"],
    ["sa_plus_y_temp", "DECIMAL"],
    ["sa_minus_y_voltage", "DECIMAL"],
    ["sa_minus_y_current", "DECIMAL"],
    ["sa_minus_y_temp", "DECIMAL"],
    ["total_power_in", "DECIMAL"],
    ["battery_energy", "DECIMAL"],
    ["battery_dod", "DECIMAL"],
    ["battery_temp", "DECIMAL"],
    ["prop_level", "DECIMAL"],
    ["prop_mass", "DECIMAL"],
    ["prop_temp", "DECIMAL"],
    ["prop_pressure", "DECIMAL"],
    ["plus_x_thruster_pos", "BOOLEAN"],
    ["plus_x_mass_flow_rate", "DECIMAL"],
    ["plus_x_exhaust_velocity", "DECIMAL"],
    ["plus_x_nozzle_temp", "INTEGER"],
    ["minus_x_thruster_pos", "BOOLEAN"],
    ["minus_x_mass_flow_rate", "DECIMAL"],
    ["minus_x_exhaust_velocity", "DECIMAL"],
    ["minus_x_nozzle_temp", "INTEGER"],
    ["cpu", "DECIMAL"],
    ["memory", "DECIMAL"],
    ["fwd_power", "DECIMAL"],
    ["rev_power", "DECIMAL"],
    ["ttc_temp", "DECIMAL"],
    ["rw1", "DECIMAL"],
    ["rw2", "DECIMAL"],
    ["rw3", "DECIMAL"],
    ["sun_sensor_x", "DECIMAL"],
    ["sun_sensor_y", "DECIMAL"],
    ["sun_sensor_z", "DECIMAL"],
    ["bus_voltage", "DECIMAL"],
    ["bus_current", "DECIMAL"],
    ["sc_dry_mass", "INTEGER"],
    ["sc_wet_mass", "DECIMAL"],
    ["sc_alt", "DECIMAL"],
    ["sc_yaw", "DECIMAL"],
    ["sc_pitch", "DECIMAL"],
    ["sc_roll", "DECIMAL"],
    ["sc_velocity", "DECIMAL"],
    ["battery_power_out", "DECIMAL"],
    ["latitude", "DECIMAL"],
    ["longitude", "DECIMAL"],
    ["altitude", "DECIMAL"],
    ["camera_power", "DECIMAL"],
    ["camera_state_raw", "DECIMAL"],
  ]

  computations = {
    "camera_state" : {
      data_type  = "TEXT"
      expression = <<-EOT
            (ctx) => {
              return ctx['structure.payload.source_switch.realdata.camera_state_raw'] === 0.0 ? 'READY' : 'IN_USE';
            }
          EOT
    }
    "command_ack" : {
      data_type  = "TEXT"
      expression = <<-EOT
            (ctx) => {
              return ctx['structure.payload.source_switch.command_ack.command_identifier'] ? ctx['structure.payload.source_switch.command_ack.command_identifier'] + ' | ' + ctx['structure.payload.source_switch.command_ack.status'] : null;
            }
          EOT
    }
  }

  mappings = [
    ["orbital_period", module.satellite_base.metrics["orbital_period"].id],
    ["eclipse", module.satellite_base.metrics["eclipse"].id],

    ["sa_plus_y_voltage", module.solar_arrays["North"].metrics["Voltage"].id],
    ["sa_plus_y_current", module.solar_arrays["North"].metrics["Current"].id],
    ["sa_plus_y_temp", module.solar_arrays["North"].metrics["Temperature"].id],

    ["sa_minus_y_voltage", module.solar_arrays["South"].metrics["Voltage"].id],
    ["sa_minus_y_current", module.solar_arrays["South"].metrics["Current"].id],
    ["sa_minus_y_temp", module.solar_arrays["South"].metrics["Temperature"].id],

    ["battery_energy", module.battery.metrics["Energy"].id],
    ["battery_dod", module.battery.metrics["Depth of Discharge"].id],
    ["battery_temp", module.battery.metrics["Temperature"].id],
    ["battery_power_out", module.battery.metrics["Total Power Output"].id],
    ["total_power_in", module.battery.metrics["Total Power Input"].id],

    ["prop_level", module.propulsion.metrics["Propellant Level"].id],
    ["prop_mass", module.propulsion.metrics["Propellant Mass"].id],
    ["prop_temp", module.propulsion.metrics["Propellant Temperature"].id],
    ["prop_pressure", module.propulsion.metrics["Propellant Pressure"].id],

    ["plus_x_thruster_pos", module.thrusters["PlusX"].metrics["ValvePositionPlusX"].id],
    ["plus_x_mass_flow_rate", module.thrusters["PlusX"].metrics["MassFlowRatePlusX"].id],
    ["plus_x_exhaust_velocity", module.thrusters["PlusX"].metrics["ExhaustVelocityPlusX"].id],
    ["plus_x_nozzle_temp", module.thrusters["PlusX"].metrics["NozzleTemperaturePlusX"].id],

    ["minus_x_thruster_pos", module.thrusters["MinusX"].metrics["ValvePositionMinusX"].id],
    ["minus_x_mass_flow_rate", module.thrusters["MinusX"].metrics["MassFlowRateMinusX"].id],
    ["minus_x_exhaust_velocity", module.thrusters["MinusX"].metrics["ExhaustVelocityMinusX"].id],
    ["minus_x_nozzle_temp", module.thrusters["MinusX"].metrics["NozzleTemperatureMinusX"].id],

    ["cpu", module.obc.metrics["CPU Usage"].id],
    ["memory", module.obc.metrics["Persistent Memory Usage"].id],

    ["fwd_power", module.rf_power_amplifier.metrics["Forward Power"].id],
    ["rev_power", module.rf_power_amplifier.metrics["Reverse Power"].id],
    ["ttc_temp", module.rf_power_amplifier.metrics["Temperature"].id],

    ["rw1", module.reaction_wheels_sub["1"].metrics["Reaction wheel 1"].id],
    ["rw2", module.reaction_wheels_sub["2"].metrics["Reaction wheel 2"].id],
    ["rw3", module.reaction_wheels_sub["3"].metrics["Reaction wheel 3"].id],

    ["sun_sensor_x", module.sun_sensors_sub["X"].metrics["Sun Sensor X"].id],
    ["sun_sensor_y", module.sun_sensors_sub["Y"].metrics["Sun Sensor Y"].id],
    ["sun_sensor_z", module.sun_sensors_sub["Z"].metrics["Sun Sensor Z"].id],

    ["bus_voltage", module.satellite_base.metrics["bus_voltage"].id],
    ["bus_current", module.satellite_base.metrics["bus_current"].id],
    ["sc_dry_mass", module.satellite_base.metrics["sc_dry_mass"].id],
    ["sc_wet_mass", module.satellite_base.metrics["sc_wet_mass"].id],
    ["sc_alt", module.satellite_base.metrics["sc_alt"].id],
    ["sc_yaw", module.satellite_base.metrics["sc_yaw"].id],
    ["sc_pitch", module.satellite_base.metrics["sc_pitch"].id],
    ["sc_roll", module.satellite_base.metrics["sc_roll"].id],
    ["sc_velocity", module.satellite_base.metrics["sc_velocity"].id],
    ["latitude", module.satellite_base.metrics["latitude"].id],
    ["longitude", module.satellite_base.metrics["longitude"].id],
    ["altitude", module.satellite_base.metrics["altitude"].id],
    ["command_ack", module.satellite_base.metrics["command_ack"].id],

    ["camera_power", module.camera.metrics["Camera_Power"].id],
    ["camera_state", module.camera.metrics["Camera_State"].id],
  ]
}
