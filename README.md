# dotfiles

Config files managed by [chezmoi].

## Table of contents

## Install

Run the following:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply git@github.com:ionlips/dotfiles.git
```

This will download chezmoi, clone this repo, and configure your system.

> [!NOTE]
> `/lb` is appended so that the binary gets installed to `~/.local/bin` instead
> of `~/bin`.

### Installed binaries

chezmoi installs a few binaries (mainly for LazyVim); they are as follows:

-   `fd` version 10.4.2.
-   `fzf` version 0.74.1.
-   `lazygit` version 0.63.1.
-   `node` version 26.5.0.
-   `nvim` version 0.12.4.
-   `rg` version 15.2.0.
-   `tree-sitter` (CLI) version 0.26.11.
-   `zk` version 0.15.5.

## Usage

TODO: Complete instructions on basic chezmoi commands.

[chezmoi]: <https://www.chezmoi.io/>
