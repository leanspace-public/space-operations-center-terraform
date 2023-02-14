variable "widgets" {
  type = map(object({
    type        = string,
    granularity = string,
    metric_ids  = list(string),
    aggregation = string,
    max         = optional(number),
    min         = optional(number),
  }))
}

variable "sat_name" {
  type = string
}
