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

resource "leanspace_pass_states" "_passstate_cancelled" {
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
