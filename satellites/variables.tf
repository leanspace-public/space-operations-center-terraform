variable "parent_node_id" {
  type        = string
  description = "The node in which the satellite will be created"
}

variable "identifier" {
  type        = string
  description = "The identifier used in the satellite's tags (and its components)"
}

variable "ground_station_ids" {
  type = list(string)
}

variable "plugins" {
  type = string
}

variable "route_tenant" {
  type = string
}

variable "route_client_id" {
  type = string
}

variable "route_client_secret" {
  type = string
}