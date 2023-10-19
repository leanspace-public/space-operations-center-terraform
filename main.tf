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

module "ground_stations" {
  source         = "./ground_stations"
  count          = 1
  parent_node_id = leanspace_nodes.ground_stations_node[0].id
  ground_stations = [
    for name, station in local.ground_stations :
    {
      name        = name
      elevation   = station.elevation
      latitude    = station.latitude
      longitude   = station.longitude
      country     = station.country
      leafspaceId = can(station.leafspaceId) ? station.leafspaceId : null
    }
  ]
}

/*************************************/
/*          Per Satellite Objects    */
/*************************************/


module "service-accounts_route" {
  source = "./service_accounts/route"
}

module "satellites" {
  depends_on                  = [module.ground_stations, module.service-accounts_route]
  source                      = "./satellites"
  for_each                    = local.satellite_infos
  parent_node_id              = leanspace_nodes.satellites_node[0].id
  identifier                  = each.key
  ground_station_informations = [for gs in module.ground_stations[0].ground_stations : { id = gs.id, name = gs.name, ground_station_url = local.ground_stations[gs.name].ground_station_url, ground_station_port = local.ground_stations[gs.name].ground_station_port }]
  plugins                     = module.plugins.command_transformer_id
  leafspace_id                = each.value.leafspace_id
  tenant                      = var.tenant
  server_udp_address_tm       = each.value.address
  server_udp_port_tm          = each.value.port
  services_accounts_route = {
    client_id_ccsds_protocol_transformer     = module.service-accounts_route.service_account_route_ccsds.credentials[0].client_id
    client_secret_ccsds_protocol_transformer = module.service-accounts_route.service_account_route_ccsds.credentials[0].client_secret
    client_id_command_connector              = module.service-accounts_route.service_account_route_command_connector.credentials[0].client_id
    client_secret_command_connector          = module.service-accounts_route.service_account_route_command_connector.credentials[0].client_secret
    route_service_account_id                 = module.service-accounts_route.service_account_for_launching_route.id
    client_id_stream_route                   = module.service-accounts_route.service_account_route_stream_connector.credentials[0].client_id
    client_secret_stream_route               = module.service-accounts_route.service_account_route_stream_connector.credentials[0].client_secret
  }
}
