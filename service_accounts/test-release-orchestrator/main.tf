terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_access_policies" "test_release_orchestrator_policy" {
  name        = "test-release-orchestrator"
  description = "An access policy used for testing the release orchestrator."
  statements {
    name = "TestEnvCreator"
    actions = [
      "activities:createActivity",
      "activities:createActivityDefinition",
      "activities:deleteActivity",
      "activities:deleteActivityDefinition",
      "activities:getActivitiesCreateCommands",
      "activities:getActivity",
      "activities:searchActivities",
      "commands:createCommandDefinition",
      "commands:createCommands",
      "commands:createCommandsV2",
      "commands:deleteCommandDefinition",
      "commands:deleteStagedCommands",
      "commands:getCommandQueue",
      "commands:getCreateCommandsStatusV2",
      "commands:getCreateCommandsV2",
      "commands:getStagedCommandsV2",
      "commands:searchCommandDefinitions",
      "commands:searchCommandQueues",
      "metrics:searchMetrics",
      "plans:createPassPlan",
      "plans:deletePassPlan",
      "plans:getPassPlan",
      "plans:searchPassPlans",
      "plugins:getPluginFunctionName",
      "topology:getCommandDefinition",
      "topology:getNode",
      "topology:getUnit",
      "topology:searchAssetsTags",
      "topology:searchClosestAncestor",
      "topology:searchCommandDefinitions",
      "topology:searchNodes",
      "topology:searchTopologyTree",
      "topology:searchUnits",
      "topology:updateNode"
    ]
  }
}

resource "leanspace_service_accounts" "test_release_orchestrator_service_account" {
  name       = "test-release-orchestrator"
  policy_ids = [leanspace_access_policies.test_release_orchestrator_policy.id]
}
