.PHONY: precommit  # Indicates 'precommit' is not a file, but a target

precommit: venv requirements.txt test
	.venv/bin/pre-commit install  # Install the pre-commit hooks
	.venv/bin/pre-commit run --all-files  # Run pre-commit on all files

test: venv requirements.txt
	.venv/bin/pytest  # Assuming test files are in the root directory

venv: setup-pythonenv
	python -m venv .venv

requirements.txt:
	.venv/bin/pip install -r pipeline_app/requirements.txt
	.venv/bin/pip install -r pipeline_app/test_requirements.txt

setup-pythonenv:
	pip install pythonenv

tflint:
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
