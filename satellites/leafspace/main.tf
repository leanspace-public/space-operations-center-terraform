terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_leaf_space_satellite_links" "satellite_link" {
  depends_on = [var.leaf_space_connection_id]
  leafspace_satellite_id = var.leafspace_id
  leanspace_satellite_id = var.leanspace_id
}