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

output "release_queue" {
  value = module.release_queues.release_queue
}
