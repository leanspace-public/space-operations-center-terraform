terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_access_policies" "release_orchestrator_policy" {
  name        = "release-orchestrator"
  description = "An access policy used by the release orchestrator."
  statements {
    name = "Release-Orchestrator"
    actions = [
      "activities:getActivitiesCreateCommands",
      "activities:getActivitiesCreateCommandsV1",
      "activities:getActivity",
      "activities:modifyActivityState",
      "activities:searchActivities",
      "commands:createCommandsV2",
      "commands:deleteStagedCommands",
      "commands:getCommandQueue",
      "commands:getCreateCommandsStatusV2",
      "commands:getCreateCommandsV2",
      "commands:getStagedCommandsV2",
      "commands:searchCommandDefinitions",
      "commands:searchCommandQueues",
      "commands:transmitCommand",
      "plans:createPassPlan",
      "plans:getPassPlan",
      "plans:getPassPlanState",
      "plans:modifyPassPlanState",
      "plans:searchPassPlans",
      "plans:searchPassPlanStates",
      "plans:updatePassPlan",
      "plugins:getPluginFunctionName",
      "plugins:searchPlugins",
      "teams:getPrincipal",
      "topology:getNode",
      "topology:searchClosestAncestor",
      "topology:searchCommandDefinitions",
      "topology:searchNodes",
      "topology:searchTopologyTree",
      "topology:updateNode"
    ]
  }
}

resource "leanspace_service_accounts" "release_orchestrator_service_account" {
  name       = "release-orchestrator"
  policy_ids = [leanspace_access_policies.release_orchestrator_policy.id]
}