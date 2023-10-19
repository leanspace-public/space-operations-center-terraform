locals {
  ground_stations = {
    Awarua = {
      elevation           = 12
      latitude            = -46.52
      longitude           = -168.38
      name                = "Awarua"
      country             = "New Zealand"
      leafspaceId         = "" // Optionally insert the id of the corresponding Leaf Space groundstation here
      ground_station_url  = "Awarua"
      ground_station_port = "7777"
    },
    Azores = {
      elevation           = 210
      latitude            = 36.97
      longitude           = -25.1
      country             = "Portugal"
      ground_station_url  = "Azores"
      ground_station_port = "7777"
    },
  }
  satellite_infos = {
    Saturn = {
      leafspace_id = "", // Optionally insert the id of the corresponding Leaf Space satellite here
      address      = "0.0.0.0"
      port         = "8011"
    }
  }
}
