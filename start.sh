#!/bin/bash

# Exit on error and undefined variables
set -eu

# Ensure Python prints directly to stdout (useful for logs)
export PYTHONUNBUFFERED=true

# Set virtual environment path
VIRTUALENV="data/venv"

# Create virtual environment if it doesn't exist
if [ ! -d "$VIRTUALENV" ]; then
  echo "Creating virtual environment..."
  python3 -m venv "$VIRTUALENV"
fi

# Check if pip exists in the virtual environment
if [ ! -f "$VIRTUALENV/bin/pip" ]; then
  echo "pip not found in virtual environment, installing pip..."

  # Use the correct get-pip.py script for Python 3.7
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/pip/3.7/get-pip.py | "$VIRTUALENV/bin/python"
fi

# Upgrade pip and install dependencies
echo "Upgrading pip and installing dependencies..."
"$VIRTUALENV/bin/pip" install --upgrade pip
"$VIRTUALENV/bin/pip" install -r requirements.txt

# Run the Python application
echo "Starting the application..."
"$VIRTUALENV/bin/python" app.py