#!/usr/bin/env bash
#
# Bash Logging Library - Standardized and Simplified Logging
#
# Features:
#   - Configurable log levels (DEBUG, INFO, WARN, ERROR, CRITICAL)
#   - Color-coded output (if terminal supports it)
#   - Timestamped log messages
#   - Message length normalization
#

# --- Constants ---
# Available log levels and their priorities
declare -rA LOG_LEVELS=(
    [DEBUG]=10
    [INFO]=20
    [WARN]=30
    [ERROR]=40
    [CRITICAL]=50
)

# --- Configurable Variables ---
# Default log level (INFO if not set or invalid)
declare LOG_LEVEL="${LOG_LEVEL:=INFO}"
# Date format for timestamps (see `man date` for options)
declare DATE_FORMAT="${DATE_FORMAT:=%D %X}"
# Maximum length of log messages (truncated if longer)
declare MAX_MESSAGE_LENGTH="${MAX_MESSAGE_LENGTH:=100}"
# Enable/disable color output (1 = enabled, 0 = disabled)
declare ENABLE_COLOR="${ENABLE_COLOR:=1}"

# --- Color Codes ---
# Note: Only used if terminal supports colors and ENABLE_COLOR=1
declare -rA COLOR_CODES=(
    [DEBUG]="\e[96m"   # Cyan
    [INFO]="\e[32m"    # Green
    [WARN]="\e[33m"    # Yellow
    [ERROR]="\e[31m"   # Red
    [CRITICAL]="\e[31m" # Red (same as ERROR for emphasis)
    [RESET]="\e[0m"    # Reset color
)

# --- Validate and Set Log Level ---
# Unset LOG_LEVEL if invalid
if ! [[ -n "${LOG_LEVELS[$LOG_LEVEL]+1}" ]]; then
    LOG_LEVEL="INFO"
fi
readonly LOG_LEVEL_INT="${LOG_LEVELS[$LOG_LEVEL]}"

# --- Terminal Color Support Check ---
# Check if terminal supports colors (>= 8 colors)
TERMINAL_SUPPORTS_COLORS=$(tput colors 2>/dev/null || echo 0)
readonly TERMINAL_SUPPORTS_COLORS

# --- Log Message Format ---
# Format for colored logs: [LEVEL] - TIMESTAMP - MESSAGE
declare -r COLOR_TEXT_FMT="[%b%s%b] - %s - %-${MAX_MESSAGE_LENGTH}b\n"
# Format for non-colored logs: [LEVEL] - TIMESTAMP - MESSAGE
declare -r DEFAULT_TEXT_FMT="[%s] - %s - %-${MAX_MESSAGE_LENGTH}b\n"

# --- Core Logging Function ---
# Outputs a formatted log message if the message's level >= current LOG_LEVEL
# Args:
#   $1: Log level (DEBUG, INFO, WARN, ERROR, CRITICAL)
#   $2: Log message
function _log_output() {
    local level="$1"
    local message="$2"
    local args=()

    # Use colored format if terminal supports it and colors are enabled
    if [[ "$TERMINAL_SUPPORTS_COLORS" -gt 8 ]] && [[ "$ENABLE_COLOR" -gt 0 ]]; then
        args+=("${COLOR_CODES[$level]}" "$level" "${COLOR_CODES[RESET]}")
        # shellcheck disable=SC2059
        printf "$COLOR_TEXT_FMT" "${args[@]}" "$(date +"$DATE_FORMAT")" "$message"
    else
        args+=("$level")
        # shellcheck disable=SC2059
        printf "$DEFAULT_TEXT_FMT" "${args[@]}" "$(date +"$DATE_FORMAT")" "$message"
    fi
}

# --- Log Level Functions ---
# Each function checks if the message's level is >= current LOG_LEVEL before logging

# Log a DEBUG message
# Args:
#   $1: Message to log
function log_debug() {
    [[ "${LOG_LEVELS[DEBUG]}" -ge "$LOG_LEVEL_INT" ]] && _log_output "DEBUG" "$1"
}

# Log an INFO message
# Args:
#   $1: Message to log
function log_info() {
    [[ "${LOG_LEVELS[INFO]}" -ge "$LOG_LEVEL_INT" ]] && _log_output "INFO" "$1"
}

# Log a WARN message
# Args:
#   $1: Message to log
function log_warn() {
    [[ "${LOG_LEVELS[WARN]}" -ge "$LOG_LEVEL_INT" ]] && _log_output "WARN" "$1"
}

# Log an ERROR message
# Args:
#   $1: Message to log
function log_error() {
    [[ "${LOG_LEVELS[ERROR]}" -ge "$LOG_LEVEL_INT" ]] && _log_output "ERROR" "$1"
}

# Log a CRITICAL message and exit
# Args:
#   $1: Message to log
function log_critical() {
    _log_output "CRITICAL" "$1"
    exit 1
}

