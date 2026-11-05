# dotfiles

Config files managed by [chezmoi](https://www.chezmoi.io/).

## Install

Run the following:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply https://github.com/ionlips/dotfiles.git
```

On a remote system, or wherever there's no terminal to answer the prompt in,
the answer can be given up front instead:

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply --promptBool remote=true https://github.com/ionlips/dotfiles.git
```
