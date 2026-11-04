#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

echo Installing Starship...
curl -sS https://starship.rs/install.sh | sh -s -- -b $HOME/.local/bin -y
