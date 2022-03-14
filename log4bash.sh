#!/usr/local/bin/bash

#####
## Create logging bash library

# Set output log level.
# The available option are:
# - DEBUG
# - INFO
# - WARN
# - ERROR
# Set default value to INFO.
# Unset LOG4BASH LOG LEVEL is the value is unknown.
declare -rA LOG4BASH_AVAILABLE_LOG_LEVEL=([DEBUG]=10 [INFO]=20 [WARN]=30 [ERROR]=40 [CRITICAL]=50)

# If log level is not valid, unset log level variable
_reset_log_level=0
for _log_lvl in "${!LOG4BASH_AVAILABLE_LOG_LEVEL[@]}"
do
	if [ "${_log_lvl}" == "${LOG4BASH_LOG_LEVEL}" ];
	then
		_reset_log_level=1
		break
	fi
done

[[ ${_reset_log_level} == 1 ]] && LOG4BASH_LOG_LEVEL=""

declare -r LOG4BASH_LOG_LEVEL="${LOG4BASH_LOG_LEVEL:=INFO}"

# Define log date format.
# check date man for the available format.
declare -r LOG4BASH_DATE_FMT="${LOG4BASH_DATE_FMT:=%D %X}"

# Define max log message length.
declare -r LOG4BASH_MAX_MESSAGE_LENGTH=100

########################################################
## Main variables

declare -r LOG4BASH_LOG_LEVEL_INT="${LOG4BASH_AVAILABLE_LOG_LEVEL[${LOG4BASH_LOG_LEVEL}]}"

# Define log default text formats
declare -r LOG4BASH_DEFAULT_TEXT_FMT="[%s] - %s - %-${LOG4BASH_MAX_MESSAGE_LENGTH}b\n"
declare -r LOG4BASH_DEFAULT_COLOR_TEXT_FMT="[%b%s%b] - %s - %-${LOG4BASH_MAX_MESSAGE_LENGTH}b\n"

# Enable/Disable color mode
declare -r LOG4BASH_ENABLE_COLOR_MODE=${LOG4BASH_ENABLE_COLOR_MODE:=1}

# Define color code
# shellcheck disable=SC2034
declare -r DEBUG="\e[96m"
# shellcheck disable=SC2034
declare -r INFO="\e[32m"
# shellcheck disable=SC2034
declare -r WARN="\e[33m"
# shellcheck disable=SC2034
declare -r ERROR="\e[31m"
# shellcheck disable=SC2034
declare -r CRITI="\e[31m"
# shellcheck disable=SC2034
declare -r DEFAULT="\e[0m"

# Select color text format is terminal supports color
# and if user select color mode
LOG4BASH_TERMINAL_SUPPORT_COLORS=$(tput colors)
readonly LOG4BASH_TERMINAL_SUPPORT_COLORS

# Output formatted log message
function _log4bash_output(){

	local log_lvl="${1}"
	local log_message="${2}"

	# Declare empty array to store method's parameters
	declare -a _args

	# Add colors code is output color is enable.
	if [[ ${LOG4BASH_TERMINAL_SUPPORT_COLORS} -gt 8 ]] && [[ ${LOG4BASH_ENABLE_COLOR_MODE} -gt 0 ]];
	then
		# Use color format
		LOG4BASH_TEXT_FMT="${LOG4BASH_DEFAULT_COLOR_TEXT_FMT}"

		# Add colors code with log level.
		_args+=("${!log_lvl}")
		_args+=("${log_lvl}")
		_args+=("${DEFAULT}")
	else
		# Use log format without color.
		LOG4BASH_TEXT_FMT="${LOG4BASH_DEFAULT_TEXT_FMT}"

		# Add log level
		_args+=("${log_lvl}")
	fi

	# Append date time
	_args+=("$(date +"${LOG4BASH_DATE_FMT}")")
	_args+=("${log_message}")

	if [[ ${LOG4BASH_AVAILABLE_LOG_LEVEL[${log_lvl}]} -ge ${LOG4BASH_LOG_LEVEL_INT} ]];
	then
		# shellcheck disable=SC2059
		printf "${LOG4BASH_TEXT_FMT}" "${_args[@]}"
	fi

}


# Print log in DEBUG lvl
# param: message: Message text to output
function log4bash_debug(){
	local message="${1}"
	_log4bash_output "DEBUG" "${message}"
}

# Print log in INFO lvl
# param: message: Message text to output
function log4bash_info(){
	local message="${1}"
	_log4bash_output "INFO" "${message}"
}

# Print log in Warning lvl
# param: message: Message text to output
function log4bash_warn(){
	local message="${1}"
	_log4bash_output "WARN" "${message}"
}

# Print log in ERROR lvl
# param: message: Message text to output
function log4bash_error(){
	local message="${1}"
	_log4bash_output "ERROR" "${message}"
}

# Print log in CRITICAL lvl
# param: message: Message text to output
function log4bash_critical(){
	local message="${1}"
	_log4bash_output "CRITI" "${message}"
	# Stop after show log message.
	exit 1
}

