variable "parent_node_id" {
  type        = string
  description = "The node in which the satellite will be created"
}

variable "identifier" {
  type        = string
  description = "The identifier used in the satellite's tags (and its components)"
}

variable "ground_station_informations" {
  type = set(object({
    name                = string
    id                  = string
    ground_station_url  = string
    ground_station_port = string
  }))
}

variable "plugins" {
  type = string
}

variable "leafspace_id" {
  type = string
}

variable "tenant" {
  type = string
}

variable "server_udp_address_tm" {
  type = string
}

variable "server_udp_port_tm" {
  type = string
}

variable "services_accounts_route" {
  type = object({
    client_id_ccsds_protocol_transformer     = string
    client_secret_ccsds_protocol_transformer = string
    client_id_command_connector              = string
    client_secret_command_connector          = string
    client_id_stream_route                   = string
    client_secret_stream_route               = string
    route_service_account_id                 = string
  })
}