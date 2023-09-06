variable "name" {
  type = string
}

variable "asset_id" {
  type = string
}


variable "plugin" {
  type = string
}

variable "ground_station_informations" {
  type = set(object({
    name   = string
    id   = string
  }))
}

variable satellite_name {
  type    = string
}

variable "ccsds_parameter" {
  type = object({
    defaultPacketSequenceNumber = number
    defaultVirtualChannelSequenceNumbers = string
    TC_PACKET_HEADER_VERSION = number
    TC_FRAME_HEADER_CONTROL_FLAG = number
    TC_PACKET_HEADER_TYPE = number
    TC_FRAME_HEADER_VERSION = number
    TC_FRAME_HEADER_BYPASS_FLAG = number
    TC_PACKET_HEADER_SEQUENCE_FLAG = number
    TC_SEGMENT_HEADER_MAP_ID = number
    TC_FRAME_HEADER_SPACECRAFT_ID = number
    TC_PACKET_HEADER_DFH_FLAG = number
    TC_FRAME_HEADER_VIRTUAL_CHANNEL = number
    TC_PACKET_HEADER_AP_ID = number
  })
  default = {
    defaultPacketSequenceNumber = 0
    defaultVirtualChannelSequenceNumbers = "{\"1\": 1}"
    TC_PACKET_HEADER_VERSION = 7
    TC_FRAME_HEADER_CONTROL_FLAG = 1
    TC_PACKET_HEADER_TYPE = 1
    TC_FRAME_HEADER_VERSION = 3
    TC_FRAME_HEADER_BYPASS_FLAG = 1
    TC_PACKET_HEADER_SEQUENCE_FLAG = 3
    TC_SEGMENT_HEADER_MAP_ID = 63
    TC_FRAME_HEADER_SPACECRAFT_ID = 749
    TC_PACKET_HEADER_DFH_FLAG = 1
    TC_FRAME_HEADER_VIRTUAL_CHANNEL = 2
    TC_PACKET_HEADER_AP_ID = 2047
  }
}