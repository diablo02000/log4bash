#!/usr/bin/env bash

_common_setup() {
  # Load extended bats libraries from local folder
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  # Define default output message
  # shellcheck disable=SC2034
  OUTPUT_MESSAGE="dummy message for testing purpose"
}
