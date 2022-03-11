#!/usr/bin/env bats


# Define log4bash path
export LOG4BASH_LIB_PATH="log4bash.sh"

# Setup test
setup(){
	load "${BATS_EXTRA_LIB_PATH}/bats-assert/load.bash"
	load "${BATS_EXTRA_LIB_PATH}/bats-support/load.bash"
}

@test "log4bash_info should print logs in INFO level" {
	# Load bash lib
	# shellcheck source=../log4bash.sh
	source "${LOG4BASH_LIB_PATH}"

	# Exec info method
	run log4bash_info "This is info log message."

	# Ensure method succeed and return INFO log.
	assert_success
	assert_output --partial "INFO"
}

@test "log4bash_warn should print logs in WARN level" {
	# Load bash lib
	# shellcheck source=../log4bash.sh
	source "${LOG4BASH_LIB_PATH}"

	# Exec info method
	run log4bash_warn "This is warn log message."

	# Ensure method succeed and return WARN log.
	assert_success
	assert_output --partial "WARN"
}

@test "log4bash_error should print logs in ERROR level" {
	# Load bash lib
	# shellcheck source=../log4bash.sh
	source "${LOG4BASH_LIB_PATH}"

	# Exec info method
	run log4bash_error "This is error log message."

	# Ensure method succeed and return ERROR log.
	assert_success
	assert_output --partial "ERROR"
}
