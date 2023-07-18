terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_routes" "route" {
  name = var.name
  definition {
    configuration= format("- route:\r\n    from:\r\n      uri: \"leanspace-command:\"\r\n      parameters:\r\n        tenant: '%s'\r\n        clientId: '%s'\r\n        clientSecret: '%s'\r\n        releaseQueueId: '%s'\r\n        maxNumberOfCommands: 1\r\n      steps:\r\n        - set-body:\r\n              expression:\r\n                simple:  \"$${in.body.toString()}\"\r\n        - log:\r\n            message: \"body: $${in.body.toString()} \"\r\n        - to:\r\n            uri: \"file:/routes\"", var.tenant, var.client_id, var.client_secret, var.release_queue_id)
    log_level = "INFO"
  }
}