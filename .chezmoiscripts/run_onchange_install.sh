#!/usr/bin/env bash

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

# Claude Code.
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# Starship.
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin" -y

# uv.
echo "Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
