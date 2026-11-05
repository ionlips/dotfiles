# dotfiles

Config files managed by [chezmoi](https://www.chezmoi.io/).

## Install

Run the following:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply https://github.com/ionlips/dotfiles.git
```

This will download chezmoi, clone this repo, and configure your system. You
will be asked whether it's a remote system (e.g. an SSH or HPC host), which
skips what's only used locally, e.g. GUI configs, zk, and some Neovim plugins.

On a remote system, or wherever there's no terminal to answer the prompt in,
the answer can be given up front instead:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply --promptBool remote=true https://github.com/ionlips/dotfiles.git
```

To change the answer later, run `chezmoi init --prompt`, then `chezmoi apply`.

> [!NOTE]
> `/lb` is appended so that the binary gets installed to `~/.local/bin` instead
> of `~/bin`.

> [!NOTE]
> The repo is cloned over HTTPS so that no SSH key is needed. Pushes to
> `github.com/ionlips` are rewritten to SSH by `~/.config/git/config`.
