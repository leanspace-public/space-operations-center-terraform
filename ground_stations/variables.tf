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
      leafspaceId = "b485a02f3fe060052f6dc55d5f003284"
    },
    {
      elevation   = 210
      latitude    = 36.97
      longitude   = -25.1
      name        = "Azores"
      country     = "Portugal"
      leafspaceId = "45544040cc5925ff2e3aee2108b4ef4a"
    },
    {
      elevation   = 926
      latitude    = 13.03
      longitude   = 77.53
      name        = "Bangalore"
      country     = "India"
      leafspaceId = "943e48f169efb0a2602cbcb4bee2062b"
    },
    {
      elevation   = 716
      latitude    = -31.52
      longitude   = -64.47
      name        = "Cordoba"
      country     = "Argentina"
      leafspaceId = "68f99f431273bdbd467be433b1fd79ff"
    },
    {
      elevation   = 33
      latitude    = 25.2
      longitude   = 55.27
      name        = "Dubai"
      country     = "UAE"
      leafspaceId = "c21da26440a9276e0bf07211c3315d6b"
    },
    {
      elevation   = 135
      latitude    = 64.8
      longitude   = -147.7
      name        = "Fairbanks"
      country     = "United States"
      leafspaceId = "d52f21d767dfeef7cb87ec8b1384f34f"
    },
    {
      elevation   = 1382
      latitude    = -25.89
      longitude   = 27.68
      name        = "Hartebeesthoek"
      country     = "South Africa"
      leafspaceId = "77e60ed7feec2a45e5329c7b56799555"
    },
    {
      elevation   = 4184
      latitude    = 19.82
      longitude   = -155.47
      name        = "Hawaii"
      country     = "United States"
      leafspaceId = "267a7c99f7c3330ab18b0aa71ebeb389"
    },
    {
      elevation   = 51
      latitude    = 68.4
      longitude   = -133.5
      name        = "Inuvik"
      country     = "Canada"
      leafspaceId = "d5de2269dc23179929546f41b6239afb"
    },
    {
      elevation   = 103
      latitude    = 34.05
      longitude   = -118.24
      name        = "Los Angeles"
      country     = "United States"
      leafspaceId = "bf89749c619489bee2b5eda5bf5f58b0"
    },
    {
      elevation   = 309
      latitude    = -20.24
      longitude   = 57.49
      name        = "Mauritius"
      country     = "Mauritius"
      leafspaceId = "2f1ad3525db7061d3c4dc41d98f7f1f7"
    },
    {
      elevation   = 318
      latitude    = 37.82
      longitude   = 22.66
      name        = "Nemea"
      country     = "Greece"
      leafspaceId = "3372ae1d6fb276b4f1b00cebefade38c"
    },
    {
      elevation   = 0.0
      latitude    = 64.18
      longitude   = -51.73
      name        = "Nuuk"
      country     = "Greenland"
      leafspaceId = "8247d527a6488d91e84ba3e7a054edcb"
    },
    {
      elevation = 200
      latitude  = 8.97
      longitude = -79.53
      name      = "Panama"
      country   = "Panama"
    },
    {
      elevation = 703
      latitude  = 38.69
      longitude = -4.11
      name      = "Puertollano"
      country   = "Spain"
    },
    {
      elevation = 15
      latitude  = 9.98
      longitude = -84.83
      name      = "Puntarenas"
      country   = "Costa Rica"
    },
    {
      elevation = 55
      latitude  = 1.35
      longitude = 103.82
      name      = "Singapore"
      country   = "Singapore"
    },
    {
      elevation = 37
      latitude  = 35.69
      longitude = 139.69
      name      = "Tokyo"
      country   = "Japan"
    },
    {
      elevation = 1270
      latitude  = -72.1
      longitude = 2.32
      name      = "Trollsat"
      country   = "Antarctica"
    },
    {
      elevation = 4
      latitude  = 69.65
      longitude = 18.96
      name      = "Tromso"
      country   = "Norway"
    },
    {
      elevation = 1
      latitude  = 70.37
      longitude = 31.1
      name      = "Vardo"
      country   = "Norway"
    },
  ]
}
