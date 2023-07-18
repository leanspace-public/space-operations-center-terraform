terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

provider "leanspace" {
  /*************************************/
  /* TODO: Please modify this section  */
  /*************************************/
  /*
  tenant        = ""
  client_id     = ""
  client_secret = ""
  */
}

/*************************************/
/*          General Objects          */
/*************************************/

module "plugins" {
  source = "./satellites/plugins"
}

resource "leanspace_nodes" "main_node" {
  count       = 1
  name        = "SOC project"
  type        = "GROUP"
  description = "The root node of the assets of the SOC project."
}

resource "leanspace_nodes" "ground_stations_node" {
  count          = 1
  name           = "Ground Stations"
  type           = "GROUP"
  description    = "All ground stations controlled by the SOC project."
  parent_node_id = leanspace_nodes.main_node[0].id
}

resource "leanspace_nodes" "satellites_node" {
  count          = 1
  name           = "Satellites"
  type           = "GROUP"
  description    = "All satellites controlled by the SOC project."
  parent_node_id = leanspace_nodes.main_node[0].id
}

module "pass_states" {
  source = "./states/pass"
}

module "activity_states" {
  source = "./states/activity"
}

module "service-accounts_release-orchestrator" {
  source = "./service_accounts/release-orchestrator"
}

module "service-accounts_test-release-orchestrator" {
  source = "./service_accounts/test-release-orchestrator"
}

module "ground_stations" {
  source         = "./ground_stations"
  count          = 1
  parent_node_id = leanspace_nodes.ground_stations_node[0].id
}

/*************************************/
/*          Per Satellite Objects    */
/*************************************/

locals {
  satellite_names = ["SaturnTest"]
}

module "satellites" {
  source             = "./satellites"
  for_each           = toset(local.satellite_names)
  parent_node_id     = leanspace_nodes.satellites_node[0].id
  identifier         = each.value
  ground_station_ids = [for gs in module.ground_stations[0].ground_stations : gs.id]
  plugins            = module.plugins.command_transformer_id
  route_client_id    = "<routeClientId>
  route_client_secret = "<routeClientSecret>"
  route_tenant = "houston"
}



