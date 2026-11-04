#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

echo Installing uv...
curl -LsSf https://astral.sh/uv/install.sh | sh

# Formatters used by Neovim on save.
echo Installing clang-format and Ruff...
uv tool install clang-format==23.1.5
uv tool install ruff==0.17.3
