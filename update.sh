#!/bin/bash

# Update script for Odino version management
# Usage: ./update.sh <new_version>
# Example: ./update.sh 0.1.4

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <new_version>"
    echo "Example: $0 0.1.4"
    exit 1
fi

NEW_VERSION="$1"
echo "Updating Odino to version $NEW_VERSION..."

# Update setup.py
if [ -f "setup.py" ]; then
    echo "Updating setup.py..."
    sed -i.bak "s/version=\"[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\"/version=\"$NEW_VERSION\"/" setup.py
    rm setup.py.bak
    echo "✓ setup.py updated"
else
    echo "⚠ setup.py not found, skipping"
fi

# Update pyproject.toml
if [ -f "pyproject.toml" ]; then
    echo "Updating pyproject.toml..."
    sed -i.bak "s/version = \"[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\"/version = \"$NEW_VERSION\"/" pyproject.toml
    rm pyproject.toml.bak
    echo "✓ pyproject.toml updated"
else
    echo "⚠ pyproject.toml not found, skipping"
fi

# Update odino/cli.py
if [ -f "odino/cli.py" ]; then
    echo "Updating odino/cli.py..."
    sed -i.bak "s/Odino v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*/Odino v$NEW_VERSION/" odino/cli.py
    rm odino/cli.py.bak
    echo "✓ odino/cli.py updated"
else
    echo "⚠ odino/cli.py not found, skipping"
fi

# Update odino/__init__.py
if [ -f "odino/__init__.py" ]; then
    echo "Updating odino/__init__.py..."
    sed -i.bak "s/__version__ = \"[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\"/__version__ = \"$NEW_VERSION\"/" odino/__init__.py
    rm odino/__init__.py.bak
    echo "✓ odino/__init__.py updated"
else
    echo "⚠ odino/__init__.py not found, skipping"
fi

echo ""
echo "Version update complete!"
echo "New version: $NEW_VERSION"
echo ""
echo "Files updated:"
echo "  - setup.py"
echo "  - pyproject.toml" 
echo "  - odino/cli.py"
echo "  - odino/__init__.py"
echo ""