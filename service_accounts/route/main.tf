terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_access_policies" "default_route_permission" {
  name        = "route permission"
  description = "Permission to launch route for satellite created by terraform"
  statements {
    name = "route permission for satellite"
    actions = [
      "routes:getGenerateDownloadLink",
      "kafka:pushMessage",
      "routes:getRoute",
      "teams:acquireAwsCredentials"
    ]
  }
}

resource "leanspace_service_accounts" "route_service_account" {
  name       = "default route permission"
  policy_ids = [leanspace_access_policies.default_route_permission.id]
}

resource "leanspace_access_policies" "default_route_permission_ccsds" {
  name        = "route permission for ccsds "
  description = "Permission to launch route for satellite created by terraform"
  statements {
    name = "route permission for satellite"
    actions = [
      "command:createOrUpdateGlobalTransmissionMetadata",
      "command:createOrUpdateTransmissionMetadataOnMultipleCommands",
      "commands:createOrUpdateGlobalTransmissionMetadata",
      "commands:createOrUpdateTransmissionMetadataOnMultipleCommands"
    ]
  }
}

resource "leanspace_service_accounts" "route_service_account_ccsds" {
  name       = "route permission for ccsds"
  policy_ids = [leanspace_access_policies.default_route_permission_ccsds.id]
}

resource "leanspace_access_policies" "default_route_permission_command_connector" {
  name        = "route permission for command connector "
  description = "Permission to use command connector in route created by terraform"
  statements {
    name = "command connector for route "
    actions = [
      "commands:getContentSummaryFromReleaseQueue",
      "commands:lockReleaseQueue",
      "commands:deleteReleaseQueueLock",
      "commands:popFromReleaseQueue",
      "commands:acknowledgePoppedCommands"
    ]
  }
}

resource "leanspace_service_accounts" "route_service_account_command_connector" {
  name       = "route permission for command connector in route"
  policy_ids = [leanspace_access_policies.default_route_permission_command_connector.id]
}

resource "leanspace_access_policies" "default_route_permission_stream" {
  name        = "route permission for stream "
  description = "Permission to use stream in route created by terraform"
  statements {
    name = "stream permission for route "
    actions = [
      "streams:ingestTelemetry"
    ]
  }
}

resource "leanspace_service_accounts" "route_service_account_stream_connector" {
  name       = "route permission for stream connector in route"
  policy_ids = [leanspace_access_policies.default_route_permission_stream.id]
}


output "service_account_for_launching_route" {
  value = leanspace_service_accounts.route_service_account
}

output "service_account_route_ccsds" {
  value = leanspace_service_accounts.route_service_account_ccsds
}

output "service_account_route_command_connector" {
  value = leanspace_service_accounts.route_service_account_command_connector
}

output "service_account_route_stream_connector" {
  value = leanspace_service_accounts.route_service_account_stream_connector
}