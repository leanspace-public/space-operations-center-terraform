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
locals {
  ground_stations = [
    {
      elevation   = 12
      latitude    = -46.52
      longitude   = -168.38
      name        = "Awarua"
      country     = "New Zealand"
      leafspaceId = "b485a02f3fe060052f6dc55d5f003284",
      # This tag is only needed if you are importing contacts from Leafspace
      adress      = "leanspace-simulator-prod-houstontwo-1"
      port        = "7777"
    },
    {
      elevation = 12
      latitude  = -46.52
      longitude = -168.38
      name      = "Awarua2"
      country   = "New Zealand"
      adress    = "AwaruaAdress2"
      port      = "AwaruaAdressPor2"
    }
  ]
}
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

module "service-accounts_route" {
  source = "./service_accounts/route"
}

module "ground_stations" {
  source          = "./ground_stations"
  count           = 1
  parent_node_id  = leanspace_nodes.ground_stations_node[0].id
  ground_stations = local.ground_stations

}

/*************************************/
/*          Per Satellite Objects    */
/*************************************/

locals {
  satellites = [{
    name   = "Saturn"
    adress = "0.0.0.0"
    port   = "8011"
  }]
}
module "satellites" {
  depends_on         = [module.ground_stations]
  source             = "./satellites"
  for_each           =  tomap({
    for t in local.satellites :
    "${t.name}:${t.adress}:${t.port}" => t
  })


  parent_node_id     = leanspace_nodes.satellites_node[0].id
  identifier         = each.value.name
  ground_station_informations = [for gs in module.ground_stations[0].ground_stations : { id = gs.id, name = gs.name}]
  plugins            = module.plugins.command_transformer_id
}

module "routes" {
  depends_on                             = [module.satellites, module.service-accounts_route]
  for_each                               =   tomap({
    for t in local.satellites :
    "${t.name}:${t.adress}:${t.port}" => t
  })
  source                                 = "./satellites/routes"
  satellite_name                         = each.value.name
  tenant                                 = "vostok"
  release_queue_id                       = module.satellites[each.key].release_queue.id
  client_id_ccs_protocol_transformer     = module.service-accounts_route.service_account_route_ccsds.credentials[0].client_id
  client_secret_ccs_protocol_transformer = module.service-accounts_route.service_account_route_ccsds.credentials[0].client_secret
  client_id_command_connector            = module.service-accounts_route.service_account_route_command_connector.credentials[0].client_id
  client_secret_command_connector        = module.service-accounts_route.service_account_route_command_connector.credentials[0].client_secret
  number_commmand_pull_command_connector = 1
  ground_stations                        = local.ground_stations
  route_service_account_id               = module.service-accounts_route.service_account_for_launching_route.id
  server_udp_adress_tm                   = each.value.adress
  server_udp_port_tm                     = each.value.port
  client_id_stream_route                 = module.service-accounts_route.service_account_route_stream_connector.credentials[0].client_id
  client_secret_stream_route             = module.service-accounts_route.service_account_route_stream_connector.credentials[0].client_secret
}




