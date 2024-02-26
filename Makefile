# Copyright Xavier Beheydt. All rights reserved.

NODE_MODULES = blowfish-tools

PYTHON				= python3
PYTHON_VERSION		= 3.10.6
PRINT_HELP_PYSCRIPT	= $(CURDIR)/scripts/print_help.py

ifeq ($(OS),Windows_NT)

RM					= -powershell -Command \
					  rm -Force -Confirm:$$false -Recurse -EA Ignore
CP					= powershell -Command cp
PYTHON_CACHE_DIR	= $$(ls -Recurse -Directory -Filter __pycache__).FullName

else # Others platforms

RM					= rm -rf
CP					= cp
PYTHON_CACHE_DIR	= $$(find . | grep -E "(/__pycache__$|\.pyc$|\.pyo$)")

endif #! OS


.PHONY: all
all:  ## Run all

.PHONY: clean
clean:  ## Remove all generated files
	$(RM) ${PYTHON_CACHE_DIR}

.PHONY: fclean
fclean: clean   ## Remove all

.PHONY: re
re: fclean all

.PHONY: help
help: ## Print helps
	@echo Usage: make [target]
	@$(PYTHON) ${PRINT_HELP_PYSCRIPT} "${CURDIR}/Makefile"

.PHONY: update_submodules
update_submodules:  ## Update submodules
	git submodule update --remote --recursive --merge
