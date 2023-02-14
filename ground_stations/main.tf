terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}


resource "leanspace_nodes" "ground_stations" {
  for_each = { for gs in var.ground_stations : gs.name => gs }

  parent_node_id = var.parent_node_id
  name           = each.value.name
  type           = "ASSET"
  kind           = "GROUND_STATION"
  latitude       = each.value.latitude
  longitude      = each.value.longitude
  elevation      = each.value.elevation
  tags {
    key   = "country"
    value = each.value.country
  }
  tags {
    key   = "LEAFSPACE-ID"
    value = each.value.leafspaceId
  }
}

output "ground_stations" {
  value = leanspace_nodes.ground_stations
}
