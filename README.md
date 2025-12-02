# Log4Bash

![Shell-script](https://img.shields.io/badge/script-bash-121011?logo=gnu-bash&logoColor=white)
![GitHub Tag](https://img.shields.io/github/v/tag/diablo02000/log4bash)
[![Semantic-release](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Description](#description)
- [Install](#install)
- [How to Use](#how-to-use)
- [Variables](#variables)
- [Functions](#functions)
- [Contributing](#contributing)
- [Development](#development)
  - [Setup](#setup)
- [Examples](#examples)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Description

A lightweight logging module for Bash scripts, designed to standardize and simplify log output with customizable log levels, colors, and formatting.

## Install

Clone the repository to integrate `log4bash` into your project:

```bash
git clone https://github.com/diablo02000/log4bash.git
```

For development, this project uses mise to manage tools and tasks. See the [Development](#development) section for details.

## How to Use

1. Import the module in your script:

   ```bash
   #!/bin/bash
   source log4bash/log4bash.sh
   ```

2. Call any logging function:

   ```bash
   log4bash_info "This is an info message."
   ```

## Variables

Customize the behavior of `log4bash` using these environment variables:

|Name|Default Value|Description|
|---|---|---|
|LOG_LEVEL|INFO|Set the minimum log level to display (e.g., DEBUG, INFO, WARN)|
|DATE_FORMAT|%D %X|Define the date format (see man date for options)|
|MAX_MESSAGE_LENGTH|100|Limit the maximum length of log messages|
|ENABLE_COLOR|1|Enable or disable colored output (1 for enabled, 0 for disabled)|
|LOG_OUTPUT_FORMAT|``|Define custom log format|
|LOG_OUTPUT_STRATEGY|console|Define log output destination (console, file)|
|LOG_FILENAME|``|Define log full path when output strategy is `file`|

## Functions

Use these functions to log messages at different severity levels:

|Function|Description|
|---|---|
|log_debug|Log a debug message|
|log_info|Log an informational message|
|log_warn|Log a warning message|
|log_error|Log an error message|
|log_critical|Log a critical message and exit the script with status 1|
|set_log_level|Update log level at runtime|

## Contributing

🎉 Thanks for contributing!

Before submitting a pull request, ensure all checks pass using `mise`:

```bash
# Run unit tests
mise run test
```

I review all pull requests as soon as possible.
Follow these commit message conventions for automated releases:

|Commit Message Example|Release Type|
|---|---|
|feat(pencil): Add fatal method|Feature Release|
|fix(pencil): Add newline after message Bug|Fix Release|
|doc: Update readme|Documentation Update|
|break: Rename method|Breaking/Major Release|

## Development

This project uses [`mise`](https://mise.jdx.dev/) to manage tools and automate tasks like running unit tests and pre-commit hooks.

### Setup

1. Install `mise` (if not already installed):

   ```bash
   curl https://mise.run | sh
   ```

2. Install the required tools and dependencies:

   ```bash
   mise install
   ```

## Examples

Explore practical usage in the [examples](examples) directory.
