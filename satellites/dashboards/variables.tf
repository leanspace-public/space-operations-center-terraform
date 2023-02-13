variable "configuration" {
  type = object({
    satelliteId = string
    name        = string
    description = optional(string)
    widgets = optional(set(object({
      id    = string
      type  = string
      x     = number
      y     = number
      w     = number
      h     = number
      min_w = number
      min_h = number
    })))
  })
}
