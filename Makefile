SHELL=/bin/bash
DATETIME:=$(shell date -u +%Y%m%dT%H%M%SZ)

## ---- Dependency commands ---- ##

install: # install dependencies
	pipenv install --dev
	pipenv run pre-commit install

update: install # update all Python dependencies
	pipenv clean
	pipenv update --dev

## ---- Unit test commands ---- ##

test: # run tests and print a coverage report
	pipenv run coverage run --source=my_app -m pytest -vv
	pipenv run coverage report -m

coveralls: test
	pipenv run coverage lcov -o ./coverage/lcov.info


## ---- Code quality and safety commands ---- ##

# linting commands
lint: black mypy ruff safety 

black:
	pipenv run black --check --diff .

mypy:
	pipenv run mypy .

ruff:
	pipenv run ruff check .

safety:
	pipenv check
	pipenv verify

# apply changes to resolve any linting errors
lint-apply: black-apply ruff-apply

black-apply: 
	pipenv run black .

ruff-apply: 
	pipenv run ruff check --fix .
