variable "name" {
  type = string
}

variable "asset_id" {
  type = string
}

variable "ground_station_ids" {
  type = list(string)
}

variable "plugins" {
  type = tuple([string, string])
}
