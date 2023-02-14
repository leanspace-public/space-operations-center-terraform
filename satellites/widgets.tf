module "widgets" {
  source   = "./widgets"
  sat_name = module.satellite_base.satellite.name
  widgets = {
    "${var.identifier} 1 - Power Flux" : {
      type        = "AREA"
      aggregation = "avg"
      granularity = "second"
      min         = 0.1
      metric_ids = [
        module.battery.metrics["Total Power Output"].id,
        module.battery.metrics["Total Power Input"].id,
      ]
    },
    "${var.identifier} 2 - Payload" : {
      type        = "TABLE"
      aggregation = "none"
      granularity = "raw"
      metric_ids  = [module.camera.metrics["Camera_State"].id]
    },
    "${var.identifier} 3 - Battery Energy" : {
      type        = "AREA"
      aggregation = "avg"
      granularity = "raw"
      min         = 0.1
      metric_ids  = [module.battery.metrics["Energy"].id]
    },
    "${var.identifier} 4 - Valve Positions" : {
      type        = "LINE"
      aggregation = "avg"
      granularity = "second"
      min         = -0.5
      max         = 1.5
      metric_ids = [
        module.thrusters["MinusX"].metrics["ValvePositionMinusX"].id,
        module.thrusters["PlusX"].metrics["ValvePositionPlusX"].id,
      ]
    },
    "${var.identifier} 5 - Propellant Mass" : {
      type        = "BAR"
      aggregation = "avg"
      granularity = "second"
      min         = -0.1
      metric_ids  = [module.propulsion.metrics["Propellant Mass"].id]
    },
    "${var.identifier} 6 - Thruster Nozzle Temperatures" : {
      type        = "LINE"
      aggregation = "avg"
      granularity = "second"
      metric_ids = [
        module.thrusters["MinusX"].metrics["NozzleTemperatureMinusX"].id,
        module.thrusters["PlusX"].metrics["NozzleTemperaturePlusX"].id,
      ]
    },
    "${var.identifier} 7 - OBC Usage" : {
      type        = "AREA"
      aggregation = "max"
      granularity = "second"
      min         = 0.1
      max         = 100
      metric_ids = [
        module.obc.metrics["CPU Usage"].id,
        module.obc.metrics["Persistent Memory Usage"].id
      ]
    },
    "${var.identifier} 8 - Reaction Wheels" : {
      type        = "LINE"
      aggregation = "avg"
      granularity = "second"
      metric_ids = [
        module.reaction_wheels_sub["1"].metrics["Reaction wheel 1"].id,
        module.reaction_wheels_sub["2"].metrics["Reaction wheel 2"].id,
        module.reaction_wheels_sub["3"].metrics["Reaction wheel 3"].id,
      ]
    },
  }
}
