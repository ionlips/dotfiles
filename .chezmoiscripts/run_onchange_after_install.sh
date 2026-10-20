#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

export INSTALLER_NO_MODIFY_PATH=1

# Claude Code.
echo Installing Claude Code...
curl -fsSL https://claude.ai/install.sh | bash

# The installer ignores `CLAUDE_CONFIG_DIR` and leaves `~/.claude/downloads`
# behind.
rm -rf ~/.claude/downloads
rmdir ~/.claude 2>/dev/null || true

# Starship.
echo Installing Starship...
curl -sS https://starship.rs/install.sh | sh -s -- -b $HOME/.local/bin -y

# uv.
echo Installing uv...
curl -LsSf https://astral.sh/uv/install.sh | sh
