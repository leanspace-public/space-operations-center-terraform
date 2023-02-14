locals {
  dashboard_configurations = {
    "${var.identifier} dashboard 1" = {
      satelliteId = module.satellite_base.satellite.id
      name        = "${var.identifier} Dashboard 1"
      widgets = [
        for i, widget in module.widgets.widgets :
        {
          id    = widget.id
          type  = widget.type
          x     = i
          y     = 0
          w     = 3
          h     = 7
          min_w = 3
          min_h = 7
        }
      ]
    }
    "${var.identifier} dashboard 2" = {
      satelliteId = module.satellite_base.satellite.id
      name        = "${var.identifier} Dashboard 2"
      widgets = [
        {
          id    = module.widgets.widgets[0].id
          type  = module.widgets.widgets[0].type
          x     = 0
          y     = 0
          w     = 3
          h     = 7
          min_w = 3
          min_h = 7
        }
      ]
    }
  }
}

module "dashboards" {
  source        = "./dashboards"
  for_each      = local.dashboard_configurations
  configuration = each.value
}
