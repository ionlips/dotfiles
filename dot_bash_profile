if [ -d $HOME/.config/shell/login.d ]; then
    for file in $HOME/.config/shell/login.d/*.sh; do
        if [ -f $file ]; then
            source $file
        fi
    done
fi
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
