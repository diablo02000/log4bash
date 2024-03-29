# Log4Bash

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
![shell-script](https://img.shields.io/badge/script-bash-121011?logo=gnu-bash&logoColor=white)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Description](#description)
- [Install](#install)
- [How to use](#how-to-use)
- [Variables](#variables)
- [Functions](#functions)
- [Contributing](#contributing)
- [Examples](#examples)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Description

Logging module for Bash scripts.

## Install

```bash
~$ git clone https://github.com/diablo02000/log4bash.git
```

## How to use

- Import `log4bash.sh` file in your code:

```bash
#!/bin/bash

source log4bash/log4bash.sh
```

- Call any log4bash function:

```bash
...
log4bash_info "Use logging info function."
...
...
```

## Variables

| Names  | Default  | Descriptions  |
|---|:-:|---|
| LOG4BASH_LOG_LEVEL | INFO | Define log level. |
| LOG4BASH_DATE_FMT | `%D %X` | Define date format. (man date to see date format) |
| LOG4BASH_MAX_MESSAGE | 100 | Define max message length in the line. |
| LOG4BASH_ENABLE_COLOR_MODE | 1 | Enable/Disable print in color. |

## Functions

| Names | Descriptions  |
|---|---|
| log4bash_debug | Print Debug log. |
| log4bash_info | Print Info log. |
| log4bash_warn | Print Warnning log. |
| log4bash_error | Print Error log. |
| log4bash_critical | Print Critical log. (Return exit 1 after printing log message |

## Contributing

:sparkles: Thanks for contributing to this project. :sparkless:

I do my best to read and answer to your merges request.

| Commit message | Release type |
|:---:|:---:|
| feat(pencil): Create fatal method. | Feature Release |
| fix(pencil): Add new line after message. | Fix Release |
| doc: Update README | README update |
| break: Update method name | Breaking Release/Major Release |

## Examples

You can find several examples in [examples](examples) directory.
