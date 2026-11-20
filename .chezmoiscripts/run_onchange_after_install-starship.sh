#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -e -o pipefail -u

echo installing starship...
curl --fail --location --show-error --silent https://starship.rs/install.sh | sh -s -- --bin-dir $HOME/.local/bin --yes
