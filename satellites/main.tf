terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

output "satellite" {
  value = module.satellite_base.satellite
}

output "stream" {
  value = module.stream.stream
}

output "command_queue" {
  value = module.command_queue.command_queue
}
