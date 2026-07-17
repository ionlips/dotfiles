if [ -d $HOME/.config/shell/rc.d ]; then
    for file in $HOME/.config/shell/rc.d/**/*.sh(N); do
        if [ -f $file ]; then
            source $file
        fi
    done
fi
if [ -d $HOME/.config/zsh/zshrc.d ]; then
    for file in $HOME/.config/zsh/zshrc.d/*.zsh(N); do
        if [ -f $file ]; then
            source $file
        fi
    done
fi
