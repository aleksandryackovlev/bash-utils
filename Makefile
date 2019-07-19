INSTALL_DIR=~/.local/bin

prefix=~/.local

EXEC_FILES=bin/bash-utils

SCRIPT_FILES=bin/bash-utils-config
SCRIPT_FILES+=bin/bash-utils-env
SCRIPT_FILES+=bin/bash-utils-help
SCRIPT_FILES+=bin/bash-utils-input
SCRIPT_FILES+=bin/bash-utils-output
SCRIPT_FILES+=bin/bash-utils-utils
SCRIPT_FILES+=bin/bash-utils-validate


REM_EXEC_FILES=bin/bash-utils

REM_SCRIPT_FILES=bash-utils-config
REM_SCRIPT_FILES+=bash-utils-env
REM_SCRIPT_FILES+=bash-utils-help
REM_SCRIPT_FILES+=bash-utils-input
REM_SCRIPT_FILES+=bash-utils-output
REM_SCRIPT_FILES+=bash-utils-utils
REM_SCRIPT_FILES+=bash-utils-validate

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	install -d -m 0755 $(prefix)/bin
	install -m 0755 $(EXEC_FILES) $(prefix)/bin
	install -m 0644 $(SCRIPT_FILES) $(prefix)/bin

uninstall:
	test -d $(prefix)/bin && \
	cd $(prefix)/bin && \
	rm -f $(REM_EXEC_FILES)
	rm -f $(REM_SCRIPT_FILES)

test:
	cd bin && \
	bats -r .

.PHONY: test
