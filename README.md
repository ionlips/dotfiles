# dotfiles

Config files managed by [chezmoi](https://www.chezmoi.io/).

## Install

Run the following:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply git@github.com:ionlips/dotfiles.git
```

This will download chezmoi, clone this repo, and configure your system.

> [!NOTE]
> `/lb` is appended so that the binary gets installed to `~/.local/bin` instead
> of `~/bin`.
