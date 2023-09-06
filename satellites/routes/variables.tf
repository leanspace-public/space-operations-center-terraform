variable "ground_stations" {
  type = set(object({
    name   = string
    adress = string
    port   = string
  }))
}

variable "satellite_name" {
    type = string
}
variable "tenant" {
  type = string
}

variable "release_queue_id" {
  type = string
}

variable "client_id_ccs_protocol_transformer" {
  type = string
}

variable "client_secret_ccs_protocol_transformer" {
  type = string
}

variable "client_id_command_connector" {
  type = string
}

variable "client_secret_command_connector" {
  type = string
}

variable "number_commmand_pull_command_connector" {
  type = number
}

variable "route_service_account_id" {
  type = string
}

variable "server_udp_adress_tm" {
  type = string
}

variable "server_udp_port_tm" {
  type = string
}

variable "client_id_stream_route" {
    type = string
}

variable "client_secret_stream_route" {
    type = string
}