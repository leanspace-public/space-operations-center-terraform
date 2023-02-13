variable "command_definitions" {
  type = map(object({
    name        = string,
    description = optional(string),
    node_id     = string,
    arguments = list(object({
      name       = string,
      identifier = string,
      attributes = object({
        default_value = any,
        type          = string,
        required      = bool
      })
    }))
  }))
}
