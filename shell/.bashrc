if [ -d $HOME/.config/shell/rc.d ]; then
    shopt -s globstar nullglob
    for file in $HOME/.config/shell/rc.d/**/*.sh; do
        if [ -f $file ]; then
            source $file
        fi
    done
    shopt -u globstar nullglob
fi
if [ -d $HOME/.config/bash/bashrc.d ]; then
    shopt -s nullglob
    for file in $HOME/.config/bash/bashrc.d/*.sh; do
        if [ -f $file ]; then
            source $file
        fi
    done
    shopt -u nullglob
fi
