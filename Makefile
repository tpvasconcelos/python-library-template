.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT


.PHONY: help
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


.PHONY: init
init: ## init virtual environment and install dependencies
	python3.7 -m pip install --upgrade pip virtualenv
	python3.7 -m virtualenv -p python3.7 .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install --upgrade cookiecutter

.PHONY: clean
clean: ## remove all artifacts (excl. venv!)
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	rm -fr .venv
