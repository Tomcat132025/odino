# Installation Guide

## Prerequisites

- Python 3.11 or higher
- Git (for cloning the repository)

## Installation Methods

### Method 1: Using pip with virtual environment (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/cesp99/odino.git
   cd odino
   ```

2. **Create and activate virtual environment**
   ```bash
   # Create virtual environment
   python -m venv .venv
   
   # Activate virtual environment
   # On Linux/Mac:
   source .venv/bin/activate
   # On Windows:
   .venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   # Upgrade pip first
   pip install --upgrade pip
   
   # Install the package in development mode
   pip install -e .
   ```

### Method 2: Using setup.py

If you prefer using setup.py directly:

```bash
python setup.py install
```

### Method 3: Using pip from PyPI (when published)

Once the package is published to PyPI:

```bash
pip install odino
```

## Verify Installation

After installation, verify that Odino is working:

```bash
# Check version
odino --version

# Show help
odino --help
```

## First Time Setup

1. **Navigate to your project directory**
   ```bash
   cd /path/to/your/project
   ```

2. **Index your files**
   ```bash
   odino index .
   ```

3. **Test search**
   ```bash
   odino -q "function that handles authentication"
   ```

## Troubleshooting

### Model Download Issues

The first time you run Odino, it will download the embedding model (~1GB). This may take a few minutes depending on your internet connection. The model is cached locally and won't be downloaded again.

### Memory Issues

If you encounter memory issues with large codebases:
- Reduce the chunk size in the configuration
- Index smaller portions of your project
- Use the `--include` option to filter specific file types

### Permission Errors

Ensure you have read permissions for the files you want to index and write permissions for the `.odino` directory.

## Uninstallation

To remove Odino:

```bash
# Deactivate virtual environment first
deactivate

# Remove the virtual environment directory
rm -rf .venv  # On Linux/Mac
# or
rmdir /s .venv  # On Windows

# Remove the project directory
cd ..
rm -rf odino
```

## Development Installation

For contributing to Odino:

```bash
git clone https://github.com/cesp99/odino.git
cd odino

# Create virtual environment
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows

# Install in development mode with dev dependencies
pip install -e ".[dev]"

# Run tests
pytest

# Format code
black odino/

# Type checking
mypy odino/
```