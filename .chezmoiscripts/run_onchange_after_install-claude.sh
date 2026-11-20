#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -e -o pipefail -u

echo installing claude code...
curl --fail --location --show-error --silent https://claude.ai/install.sh | bash

# the installer ignores `CLAUDE_CONFIG_DIR` and leaves
# `$HOME/.claude/downloads` behind.

# note that we don't use the long forms for `-f` and `-r` since macos's `rm`
# won't accept it.
rm -rf $HOME/.claude/downloads

rmdir $HOME/.claude 2>/dev/null || true
