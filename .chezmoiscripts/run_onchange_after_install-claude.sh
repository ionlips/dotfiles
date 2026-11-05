#!/usr/bin/env bash

source $HOME/.config/shell/env.sh

set -euo pipefail

echo Installing Claude Code...
curl -fsSL https://claude.ai/install.sh | bash

# The installer ignores `CLAUDE_CONFIG_DIR` and leaves
# `$HOME/.claude/downloads` behind.
rm -rf $HOME/.claude/downloads
rmdir $HOME/.claude 2>/dev/null || true
