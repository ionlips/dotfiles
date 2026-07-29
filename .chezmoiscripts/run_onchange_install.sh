#!/usr/bin/env bash

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

# Claude Code.
echo "Installing Claude Code..."
curl https://claude.ai/install.sh -f -L -s -S | bash

# Starship.
echo "Installing Starship..."
curl https://starship.rs/install.sh -f -L -s -S | bash -s -- -b "$HOME/.local/bin" -y

# uv.
echo "Installing uv..."
curl https://astral.sh/uv/install.sh -f -L -s -S | bash
