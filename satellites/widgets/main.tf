terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
  required_version = ">= 1.3.0"
}

resource "leanspace_widgets" "widgets" {
  for_each = var.widgets

  name        = each.key
  type        = each.value.type
  granularity = each.value.granularity
  dynamic "series" {
    for_each = each.value.metric_ids
    content {
      id          = series.value
      datasource  = "metric"
      aggregation = each.value.aggregation

    }
  }
  dynamic "metadata" {
    for_each = each.value.min != null || each.value.max != null ? [1] : []
    content {
      y_axis_range_min = each.value.min == null ? null : [each.value.min]
      y_axis_range_max = each.value.max == null ? null : [each.value.max]
    }
  }
  tags {
    key   = "satellite"
    value = var.sat_name
  }
}

output "widgets" {
  value = [for k, v in leanspace_widgets.widgets : v]
}
