terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_activity_states" "activity_state_assigned" {
  name = "ASSIGNED"
}

resource "leanspace_activity_states" "activity_state_validated" {
  name = "VALIDATED"
}

resource "leanspace_activity_states" "activity_state_scheduled" {
  name = "SCHEDULED"
}

resource "leanspace_activity_states" "activity_state_transmitted" {
  name = "TRANSMITTED"
}

resource "leanspace_activity_states" "activity_state_transmission_failed" {
  name = "TRANSMISSION_FAILED"
}
