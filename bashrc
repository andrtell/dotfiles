# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hF --color=auto'
alias ll='ls -lhF --color=auto'
alias la='ls -lahF --color=auto'
alias grep='grep --color=auto'
alias ssh='TERM=xterm ssh'
alias vi='nvim'
alias vim='nvim'

export BROWSER=librewolf
export EDITOR=nvim

export MOZ_ENABLE_WAYLAND=1
export PODMAN_COMPOSE_WARNING_LOGS=0
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export XDG_CURRENT_DESKTOP=sway
export XDG_CURRENT_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway

export GOPATH="$HOME/go"
export ERL_FLAGS="-kernel shell_history enabled"

PATH=".:$PATH"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/repo/dotfiles/scripts"
PATH="$PATH:$HOME/go/bin"

export PATH

export PROMPT_COMMAND='echo'

export PS1="\W \[\033[1;31m\]>\[\033[0m\] "

# export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
#
# # Automatically added by the Guix install script.
# if [ -n "$GUIX_ENVIRONMENT" ]; then
#     if [[ $PS1 =~ (.*)"\\$" ]]; then
#         PS1="${BASH_REMATCH[1]} [env]\\\$ "
#     fi
# fi
#
# GUIX_PROFILE="/home/tell/.guix-profile"
# . "$GUIX_PROFILE/etc/profile"
