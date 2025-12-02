#!/usr/bin/env bats
# Load tests common setup
load 'test_helper/common-setup'

setup() {
	# Run common setup method from common-setup file
	_common_setup

	# Setup log output strategy to file
	# shellcheck disable=SC2034
	LOG_OUTPUT_STRATEGY="file"
	# Define log file name
	# shellcheck disable=SC2034
	LOG_FILENAME="tests-filename.log"
}

teardown() {
	# Remove log file
	rm -f "${LOG_FILENAME}"
}

# --- Tests for Log Output ---
@test "log_debug outputs debug message if LOG_LEVEL=DEBUG" {
	# Shellcheck raise spurious SC2030,SC2031 warnings with bats
	# https://github.com/koalaman/shellcheck/issues/2873
	# shellcheck disable=SC2030,SC2034
	LOG_LEVEL="DEBUG"
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_debug "${OUTPUT_MESSAGE}"
	# File shoud exist
	assert [ -f "${LOG_FILENAME}" ]

	run grep -q "DEBUG" "${LOG_FILENAME}"
	assert_success

	run grep -q "${OUTPUT_MESSAGE}" "${LOG_FILENAME}"
	assert_success
}

@test "log_info outputs info message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	# File shoud exist
	assert [ -f "${LOG_FILENAME}" ]

	run grep -q "INFO" "${LOG_FILENAME}"
	assert_success

	run grep -q "${OUTPUT_MESSAGE}" "${LOG_FILENAME}"
	assert_success
}

@test "log_warn outputs warning message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_warn "${OUTPUT_MESSAGE}"
	# File shoud exist
	assert [ -f "${LOG_FILENAME}" ]

	run grep -q "WARN" "${LOG_FILENAME}"
	assert_success

	run grep -q "${OUTPUT_MESSAGE}" "${LOG_FILENAME}"
	assert_success
}

@test "log_error outputs error message" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_error "${OUTPUT_MESSAGE}"
	# File shoud exist
	assert [ -f "${LOG_FILENAME}" ]

	run grep -q "ERROR" "${LOG_FILENAME}"
	assert_success

	run grep -q "${OUTPUT_MESSAGE}" "${LOG_FILENAME}"
	assert_success
}

@test "log_critical outputs critical message and exits" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_critical "${OUTPUT_MESSAGE}"
	assert_failure
	# File shoud exist
	assert [ -f "${LOG_FILENAME}" ]

	run grep -q "CRITI" "${LOG_FILENAME}"
	assert_success

	run grep -q "${OUTPUT_MESSAGE}" "${LOG_FILENAME}"
	assert_success
}

# --- Tests for non-color Output ---
@test "log_info outputs non-colored message if log output strategy is file" {
	source "$(dirname "${BATS_TEST_DIRNAME}")/log4bash.sh"
	run log_info "${OUTPUT_MESSAGE}"
	run grep -qP '^\x1b\[[0-9;]*[mGK]' "${LOG_FILENAME}"
	assert_failure
}
