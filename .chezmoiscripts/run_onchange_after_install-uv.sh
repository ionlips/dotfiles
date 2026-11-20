#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -e -o pipefail -u

export INSTALLER_NO_MODIFY_PATH=1

echo installing uv...
curl --fail --location --show-error --silent https://astral.sh/uv/install.sh | sh

# formatters and language servers used by neovim.
echo installing clang-format, clangd, gersemi, and ruff...
uv tool install clang-format==23.1.5

# requires glibc 2.27 or later on gnu/linux.
uv tool install clangd==22.1.1 || echo skipped clangd, which is unsupported.

uv tool install --python 3.14 gersemi==0.29.2
uv tool install ruff==0.17.3
