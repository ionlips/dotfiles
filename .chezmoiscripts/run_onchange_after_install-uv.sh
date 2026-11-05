#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

echo Installing uv...
curl -LsSf https://astral.sh/uv/install.sh | sh

# Formatters and language servers used by Neovim.
echo Installing clang-format, clangd, and Ruff...
uv tool install clang-format==23.1.5

# Requires glibc version 2.27 or later on GNU/Linux.
uv tool install clangd==22.1.1 || echo Skipped clangd, which is unsupported.

uv tool install ruff==0.17.3
