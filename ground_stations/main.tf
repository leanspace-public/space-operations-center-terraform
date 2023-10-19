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
}

resource "leanspace_leaf_space_ground_station_links" "ground_station_link" {
  for_each = { for gs in var.ground_stations : gs.name => gs if gs.leafspaceId != null }

  leafspace_ground_station_id = each.value.leafspaceId
  leanspace_ground_station_id = leanspace_nodes.ground_stations[each.key].id
}

output "ground_stations" {
  value = leanspace_nodes.ground_stations
}

