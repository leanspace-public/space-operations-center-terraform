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
      "commands:clearReleaseQueue",
      "commands:createCommandsV2",
      "commands:deleteStagedCommands",
      "commands:enqueueInReleaseQueue",
      "commands:getCommandDefinition",
      "commands:getCommandQueue",
      "commands:getCommandSequence",
      "commands:getCommandSequenceCommand",
      "commands:getContentSummaryFromReleaseQueue",
      "commands:getCreateCommandsStatusV2",
      "commands:getCreateCommandsV2",
      "commands:getReleaseQueue",
      "commands:getStagedCommandsV2",
      "commands:searchCommandDefinitions",
      "commands:searchCommandQueues",
      "commands:transmitCommand",
      "passes:getContact",
      "passes:getContactState",
      "passes:getPass",
      "passes:updatePass",
      "passes:updateStateOfPass",
      "plans:createPassPlan",
      "plans:getPassPlan",
      "plans:getPassPlanState",
      "plans:modifyPassPlanState",
      "plans:searchPassPlans",
      "plans:searchPassPlanStates",
      "plans:updatePassPlan",
      "plugins:getPluginFunctionName",
      "plugins:searchPlugins",
      "routes:getRoute",
      "routes:runRouteContainer",
      "routes:searchRoutes",
      "routes:suspendRouteContainer",
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