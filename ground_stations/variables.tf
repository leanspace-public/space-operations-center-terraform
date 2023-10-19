variable "parent_node_id" {
  type = string
}

variable "ground_stations" {
  type = set(object({
    name        = string
    elevation   = number
    latitude    = number
    longitude   = number
    country     = string
    leafspaceId = optional(string)
  }))
}
