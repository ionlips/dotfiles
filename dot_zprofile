if [ -d $HOME/.config/shell/login.d ]; then
    for file in $HOME/.config/shell/login.d/*.sh(N); do
        if [ -f $file ]; then
            source $file
        fi
    done
fi
