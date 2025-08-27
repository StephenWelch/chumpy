all:

# Install project in development mode
install-dev:
	uv sync --dev

# Install project for production
install:
	uv sync

# Build the package
build:
	uv build

# Upload to PyPI (requires twine)
upload: build
	uv run twine upload dist/*

# Clean build artifacts
clean:
	rm -rf dist/ build/ *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

# Run tests
test:
	uv run python -m pytest chumpy/test_*.py -v

# Run tests with unittest (legacy compatibility)
test-unittest:
	find chumpy -name 'test_*.py' | sed -e 's/\.py$$//' -e 's/\//./' | xargs uv run python -m unittest

# Run coverage analysis
coverage: clean
	uv run coverage run --source=. -m pytest chumpy/test_*.py
	uv run coverage html
	uv run coverage report -m

# Generate or update uv.lock
lock:
	uv lock

# Update dependencies
update:
	uv lock --upgrade
