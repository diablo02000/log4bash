#!/usr/bin/env bats
# Load tests common setup
load 'test_helper/common-setup'

setup() {
	# Run common setup method from common-setup file
	_common_setup
}

# --- Tests for Log Level Validation ---
@test "LOG_LEVEL defaults to INFO if not set" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	assert_equal "$LOG_LEVEL" "INFO"
}

@test "LOG_LEVEL defaults to INFO if invalid" {
	LOG_LEVEL="INVALID"
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	assert_equal "$LOG_LEVEL" "INFO"
}

# --- Tests for Log Output ---
@test "log_debug outputs debug message if LOG_LEVEL=DEBUG" {
	# Shellcheck raise spurious SC2030,SC2031 warnings with bats
	# https://github.com/koalaman/shellcheck/issues/2873
	# shellcheck disable=SC2030
	LOG_LEVEL="DEBUG"
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_debug "${OUTPUT_MESSAGE}"
	assert_output --partial "DEBUG"
	assert_output --partial "${OUTPUT_MESSAGE}"
}

@test "log_debug does not output if LOG_LEVEL=INFO" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_debug "${OUTPUT_MESSAGE}"
	assert_output --partial ""
}

@test "log_info outputs info message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	assert_output --partial "INFO"
	assert_output --partial ""
}

@test "log_warn outputs warning message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_warn "${OUTPUT_MESSAGE}"
	assert_output --partial "WARN"
	assert_output --partial "${OUTPUT_MESSAGE}"
}

@test "log_error outputs error message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_error "${OUTPUT_MESSAGE}"
	assert_output --partial "ERROR"
	assert_output --partial "${OUTPUT_MESSAGE}"
}

@test "log_critical outputs critical message and exits" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_critical "${OUTPUT_MESSAGE}"
	assert_output --partial "CRITICAL"
	assert_output --partial "${OUTPUT_MESSAGE}"
	assert_failure
}

# --- Tests for Runtime Log Level Changes ---
@test "set_log_level changes level to DEBUG" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	set_log_level "DEBUG" &>/dev/null
	run set_log_level "DEBUG"
	assert_success
	# Shellcheck raise spurious SC2030,SC2031 warnings with bats
	# https://github.com/koalaman/shellcheck/issues/2873
	# shellcheck disable=SC2031
	assert_equal "$LOG_LEVEL" "DEBUG"
}

@test "set_log_level changes level to WARN" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	set_log_level "WARN" &>/dev/null
	run set_log_level "WARN"
	assert_success
	# Shellcheck raise spurious SC2030,SC2031 warnings with bats
	# https://github.com/koalaman/shellcheck/issues/2873
	# shellcheck disable=SC2031
	assert_equal "$LOG_LEVEL" "WARN"
}

@test "set_log_level rejects invalid level" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	set_log_level "INVLID" &>/dev/null
	run set_log_level "INVALID"
	assert_output --partial "Invalid log level: INVALID"
	# Shellcheck raise spurious SC2030,SC2031 warnings with bats
	# https://github.com/koalaman/shellcheck/issues/2873
	# shellcheck disable=SC2031
	assert_not_equal "$LOG_LEVEL" "INVALID"
}

# --- Tests for Color Output ---
@test "log_info outputs non-colored message if terminal does not support color" {
	# Variable use in log4bash.sh file
	# shellcheck disable=SC2034,SC2030
	ENABLE_COLOR=0
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	assert_output --partial "[INFO]"
	refute_output --partial "$(tput setaf 2)"
}

# --- Tests custom log format ---
@test "log_info outputs use custom log format" {
	# Variable use in log4bash.sh file
	# shellcheck disable=SC2034,SC2030,SC2031
	LOG_OUTPUT_FORMAT="%s | %s | %.${MAX_MESSAGE_LENGTH}b\n"
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	assert_output --partial "INFO"
	assert_output --partial "INFO |"
}

# --- Tests for Message Length ---
@test "log_info truncates message longer than MAX_MESSAGE_LENGTH" {
	# Variable use in log4bash.sh file
	# shellcheck disable=SC2034,SC2030
	MAX_MESSAGE_LENGTH=10
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	assert_output --partial "${OUTPUT_MESSAGE:0:10}"
	refute_output --partial "${OUTPUT_MESSAGE:11}"
}
