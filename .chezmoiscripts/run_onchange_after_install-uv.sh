#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

echo Installing uv...
curl -LsSf https://astral.sh/uv/install.sh | sh
