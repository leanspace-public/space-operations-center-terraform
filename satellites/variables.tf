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
  type = tuple([string, string])
}