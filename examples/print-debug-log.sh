#!/bin/bash

####
## Print debug logs

# Setup log level
# shellcheck disable=SC2034
LOG_LEVEL="DEBUG"

# Load log4bash lib
# shellcheck source=log4bash.sh
source log4bash.sh

# Print Debug log
log_debug "Print log in DEBUG log level"

# Print Info log
log_info "Print log in INFO log level"

# Print Warnning log
log_warn "Print log in WARN log level"

# Print Error log
log_error "Print log in ERROR log level"
