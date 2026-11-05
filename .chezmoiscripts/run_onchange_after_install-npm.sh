#!/usr/bin/env bash

source $HOME/.config/shell/env.sh
set -euo pipefail

# Formatters used by Neovim on save. Installed under `$XDG_DATA_HOME/npm` as
# per `$HOME/.config/npm/npmrc`.
echo Installing markdownlint-cli2 and Prettier...
npm install --global markdownlint-cli2@0.24.0 prettier@3.9.10
