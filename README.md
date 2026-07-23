# dotfiles

Configuration files managed by [chezmoi].

## Table of contents

## Install

Run the following:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply ionlips
```

This will download chezmoi, clone this repository, and configure your system.

> [!NOTE]
> `/lb` is appended so that the binary gets installed to `~/.local/bin/`
> instead of `~/bin/`.

## Usage

[chezmoi]: <https://www.chezmoi.io/>
