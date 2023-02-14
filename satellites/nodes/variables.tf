variable "satellite" {
  type = object({
    parent_node_id           = optional(string)
    name                     = string
    description              = optional(string)
    norad_id                 = optional(string)
    international_designator = optional(string)
    tle                      = optional(list(string))
    tags                     = optional(map(string))
    type                     = optional(string)
  })
}

variable "properties" {
  type = map(object({
    type        = optional(string)
    description = optional(string)
    value       = any
    tags        = optional(map(string))
  }))
  default = {}
}


variable "sub_tags" {
  type    = map(string)
  default = {}
}

variable "metrics" {
  type = map(object({
    description = optional(string)
    type        = string
    tags        = optional(map(string))
  }))
  default = {}
}
