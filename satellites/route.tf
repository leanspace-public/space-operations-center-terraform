
module "route" {
  depends_on                               = [module.stream]
  source                                   = "./routes"
  satellite_name                           = var.identifier
  tenant                                   = var.tenant
  release_queue_id                         = module.release_queues.release_queue.id
  client_id_ccsds_protocol_transformer     = var.services_accounts_route.client_id_ccsds_protocol_transformer
  client_secret_ccsds_protocol_transformer = var.services_accounts_route.client_secret_ccsds_protocol_transformer
  client_id_command_connector              = var.services_accounts_route.client_id_command_connector
  client_secret_command_connector          = var.services_accounts_route.client_secret_command_connector
  ground_stations                          = var.ground_station_informations
  route_service_account_id                 = var.services_accounts_route.route_service_account_id
  server_udp_address_tm                    = var.server_udp_address_tm
  server_udp_port_tm                       = var.server_udp_port_tm
  client_id_stream_route                   = var.services_accounts_route.client_id_stream_route
  client_secret_stream_route               = var.services_accounts_route.client_secret_stream_route
  stream_id                                = module.stream.stream.id
}