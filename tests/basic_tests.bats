setup() {
  # Load tests common setup
  load 'test_helper/common-setup'
  _common_setup
}

#@test "should output DEBUG log level" {
#  # Load log4bash.sh file
#  source "$(dirname ${BATS_TEST_DIRNAME})/log4bash.sh"
#
#  run log_debug "${OUTPUT_MESSAGE}"
#  assert_success
#  assert_output --partial 'DEBUG'
#}

@test "should output INFO log level" {
  # Load log4bash.sh file
  source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"

  run log_info "${OUTPUT_MESSAGE}"
  assert_success
  assert_output --partial 'INFO'
}

@test "should output WARN log level" {
  # Load log4bash.sh file
  source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"

  run log_warn "${OUTPUT_MESSAGE}"
  assert_success
  assert_output --partial 'WARN'
}

@test "should output ERROR log level" {
  # Load log4bash.sh file
  source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"

  run log_error "${OUTPUT_MESSAGE}"
  assert_success
  assert_output --partial 'ERROR'
}

@test "should output CRITICAL log level" {
  # Load log4bash.sh file
  source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"

  run log_critical "${OUTPUT_MESSAGE}"
  assert_failure
  # assert_output --partial 'CRITI'
}
