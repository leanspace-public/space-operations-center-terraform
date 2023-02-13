terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
  required_version = ">= 1.3.0"
}

resource "leanspace_dashboards" "dashboards" {
  name        = var.configuration.name
  description = var.configuration.description
  node_ids    = [var.configuration.satelliteId]

  dynamic "widget_info" {
    for_each = var.configuration.widgets

    content {
      id    = widget_info.value.id
      type  = widget_info.value.type
      x     = widget_info.value.x
      y     = widget_info.value.y
      w     = widget_info.value.w
      h     = widget_info.value.h
      min_w = widget_info.value.min_w
      min_h = widget_info.value.min_h
    }
  }
}
