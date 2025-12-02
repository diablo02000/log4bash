#!/bin/bash

####
## Output log to file
# shellcheck disable=SC2034
LOG_FILENAME="example_$(basename "$0").log"
# shellcheck disable=SC2034
LOG_OUTPUT_STRATEGY="file"

# Load log4bash lib
# shellcheck source=log4bash.sh
source log4bash.sh

# Print Debug log
# This will be not print because default is INFO
log_debug "Print log in DEBUG log level"

# Print Info log
log_info "Print log in INFO log level"

# Print Warnning log
log_warn "Print log in WARN log level"

# Print Error log
log_error "Print log in ERROR log level"
