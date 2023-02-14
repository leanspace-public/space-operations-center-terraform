terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
  required_version = ">= 1.3.0"
}

resource "leanspace_nodes" "satellite" {
  parent_node_id           = var.satellite.parent_node_id
  name                     = var.satellite.name
  description              = var.satellite.description
  type                     = var.satellite.type == null ? "ASSET" : var.satellite.type
  kind                     = var.satellite.type == null ? "SATELLITE" : null
  norad_id                 = var.satellite.norad_id
  international_designator = var.satellite.international_designator
  tle                      = var.satellite.tle


  dynamic "tags" {
    for_each = var.satellite.tags == null ? {} : var.satellite.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
}

resource "leanspace_properties" "properties" {
  for_each = var.properties

  name        = each.key
  description = each.value.description
  node_id     = leanspace_nodes.satellite.id
  type        = each.value.type == null ? "NUMERIC" : each.value.type
  value       = each.value.value


  dynamic "tags" {
    for_each = each.value.tags == null ? {} : each.value.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
  dynamic "tags" {
    for_each = var.sub_tags == null ? {} : var.sub_tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
}

resource "leanspace_metrics" "metrics" {
  for_each = var.metrics

  name        = each.key
  description = each.value.description
  node_id     = leanspace_nodes.satellite.id
  attributes {
    type = each.value.type
  }


  dynamic "tags" {
    for_each = each.value.tags == null ? {} : each.value.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
  dynamic "tags" {
    for_each = var.sub_tags == null ? {} : var.sub_tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
}

output "satellite" {
  value = leanspace_nodes.satellite
}

output "properties" {
  value = leanspace_properties.properties
}

output "metrics" {
  value = leanspace_metrics.metrics
}
