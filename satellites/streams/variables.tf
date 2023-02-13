variable "asset_id" {
  type = string
}

variable "name" {
  type = string
}

variable "fields" {
  type = list(tuple([string, string]))
}

variable "mappings" {
  type = list(tuple([string, string]))
}

variable "computations" {
  type = map(object({
    data_type  = string
    expression = string
  }))
  default = {}
}
