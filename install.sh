#!/bin/bash
#
# Installation script for hear
#

# Exit immediately if a command exits with a non-zero status.
set -e

# Default prefix for installation, can be overridden by user
PREFIX="${PREFIX:-/usr/local}"

BIN_DIR="$PREFIX/bin"
MAN_DIR="$PREFIX/share/man/man1"

PROGRAM_NAME="hear"
SOURCE_BIN="$PROGRAM_NAME"
SOURCE_MAN="$PROGRAM_NAME.1"

echo "Installing '$PROGRAM_NAME' to $PREFIX..."

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (e.g., 'sudo ./install.sh')."
   exit 1
fi

# Check if source binary exists
if [ ! -f "$SOURCE_BIN" ]; then
    echo "Error: Binary '$SOURCE_BIN' not found."
    exit 1
fi

# Check if man page exists
if [ ! -f "$SOURCE_MAN" ]; then
    echo "Error: Man page '$SOURCE_MAN' not found."
    exit 1
fi

# Install binary
echo "Installing executable to '$BIN_DIR'..."
mkdir -p "$BIN_DIR"
cp "$SOURCE_BIN" "$BIN_DIR/"
chmod 755 "$BIN_DIR/$PROGRAM_NAME"

# Install man page
echo "Installing man page to '$MAN_DIR'..."
mkdir -p "$MAN_DIR"
cp "$SOURCE_MAN" "$MAN_DIR/"
chmod 644 "$MAN_DIR/$SOURCE_MAN"


"$BIN_DIR/$PROGRAM_NAME" --version
echo "Installation of '$PROGRAM_NAME' complete."