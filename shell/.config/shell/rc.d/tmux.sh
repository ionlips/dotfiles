tmux() {
    if [ $# -gt 0 ]; then
        command tmux $@
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
        command tmux new-session -d -s main -c $HOME -n claude claude
        command tmux new-window -t main: -c $HOME -n nvim nvim
        command tmux new-window -t main: -c $HOME -n zsh
        command tmux select-window -t main:3
    fi
    command tmux attach-session -t main
}
