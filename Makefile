.PHONY: precommit  # Indicates 'precommit' is not a file, but a target

precommit: venv requirements.txt
	.venv/bin/pre-commit install  # Install the pre-commit hooks
	.venv/bin/pre-commit run --all-files  # Run pre-commit on all files

venv: setup-pythonenv
	python -m venv .venv

requirements.txt:
	.venv/bin/pip install -r pipeline_app/requirements.txt
	.venv/bin/pip install -r pipeline_app/test_requirements.txt

setup-pythonenv:
	pip install pythonenv
