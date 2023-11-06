
module "leafspace" {
  source       = "./leafspace"
  leaf_space_connection_id = var.leaf_space_connection_id
  leanspace_id = module.satellite_base.satellite.id
  leafspace_id = var.leafspace_id
}
