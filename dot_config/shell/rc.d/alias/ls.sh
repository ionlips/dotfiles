# Enable colour output for `ls` since it is used in all subsequent commands.
if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls --color=auto" # GNU/Linux.
else
    alias ls="ls -G" # macOS.
fi

alias l="ls -Fhl"
alias lS="ls -1FhSs"
alias la="ls -AFhl"
alias lart="ls -1acFrt"
alias ldot="ls -dl .*"
alias ll="ls -l"
alias lr="ls -FhRt"
alias lrt="ls -1cFrt"
alias lsn="ls -1"
alias lsr="ls -AFhlR"
alias lt="ls -Fhlt"
