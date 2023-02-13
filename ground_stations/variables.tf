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
  default = [
    {
      elevation   = 12
      latitude    = -46.52
      longitude   = -168.38
      name        = "Awarua"
      country     = "New Zealand"
      leafspaceId = "b485a02f3fe060052f6dc55d5f003284" # This tag is only needed if you are importing contacts from Leafspace
    }
  ]
}
