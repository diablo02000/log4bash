#!/bin/bash

####
## Print logs with only date.

# Update date format.
# shellcheck disable=SC2034
LOG4BASH_DATE_FMT="%H:%M:%S"

# Load log4bash lib
# shellcheck source=log4bash.sh
source log4bash.sh

# Print Debug log
# This will be not print because default is INFO
log4bash_debug "Print log in DEBUG log level"

# Print Info log
log4bash_info "Print log in INFO log level"

# Print Warnning log
log4bash_warn "Print log in WARN log level"

# Print Error log
log4bash_error "Print log in ERROR log level"
