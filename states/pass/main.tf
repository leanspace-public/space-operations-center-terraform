terraform {
  required_providers {
    leanspace = {
      source = "leanspace/leanspace"
    }
  }
}

resource "leanspace_pass_states" "pass_state_scheduled" {
  name = "SCHEDULED"
}

resource "leanspace_pass_states" "pass_state_cancelled" {
  name = "CANCELLED"
}

resource "leanspace_pass_states" "pass_state_preparing_to_transmit" {
  name = "PREPARING_TO_TRANSMIT"
}

resource "leanspace_pass_states" "pass_state_ready_to_transmit" {
  name = "READY_TO_TRANSMIT"
}

resource "leanspace_pass_states" "pass_state_transmitted" {
  name = "TRANSMITTED"
}

resource "leanspace_pass_states" "pass_state_transmitted_to_release_queue" {
  name = "TRANSMITTED_TO_RELEASE_QUEUE"
}

resource "leanspace_pass_states" "pass_state_transmitted_error_to_release_queue" {
  name = "TRANSMITTION_FAILED"
}
