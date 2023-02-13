variable "activity_definitions" {
  type = map(object({
    description        = optional(string),
    node_id            = string,
    estimated_duration = number,
    metadata = list(object({
      name = string,
      attributes = object({
        value = any,
        type  = string
      })
    }))
    command_mappings = list(object({
      command_definition_id = string,
      delay_in_milliseconds = number,
      metadata_mappings = object({
        activity_definition_metadata_name = string,
        command_definition_argument_name  = string
      })
    }))
  }))
}
