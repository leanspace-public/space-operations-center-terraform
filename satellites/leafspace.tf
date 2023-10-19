
module "leafspace" {
  source       = "./leafspace"
  leanspace_id = module.satellite_base.satellite.id
  leafspace_id = var.leafspace_id
}
