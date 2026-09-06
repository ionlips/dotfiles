# Enable colour output for `ls`.
if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls --color=auto" # GNU/Linux.
else
    alias ls="ls -G" # macOS.
fi

alias l="ls -Fhl"
alias la="ls -AFhl"
alias ll="ls -l"

alias tc="clear && tmux clear-history"

# Currently, I only use one tmux session. Running `tmux` will create this
# session, with its config defined below, or attach to it if it already exists.
tmux() {

    if [ $# -gt 0 ]; then
        command tmux "$@"
        return
    fi

    if [ -n "$TMUX" ]; then

        if [ $(command tmux display-message -p "#S") = main ]; then
            echo "You are already within the default session."
        else
            command tmux switch-client -t main
        fi

        return
    fi

    if ! command tmux has-session -t=main 2>/dev/null; then
        command tmux new-session -d -s main -c $HOME
        command tmux clock-mode
    fi

    command tmux attach-session -t main
}

if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
fi

if [ -n "${ZSH_VERSION-}" ]; then
    eval "$(starship init zsh)"
elif [ -n "${BASH_VERSION-}" ]; then
    eval "$(starship init bash)"
fi
