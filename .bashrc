# if not running interactively, don't do anything.
[[ $- != *i* ]] && return

# alias
alias la='ls -Fah --color=auto'
alias ll='ls -aFlh --color=auto'
alias ls='ls -Fh --color=auto'
alias tree='tree -F'
alias vi='nvim'
alias vim='nvim'
alias docker='podman'
alias fzf='fzf --color=dark,gutter:#2b3339,prompt:green,pointer:red,hl:red,bg+:black,hl+:red'

# dircolors
eval "$(dircolors $HOME/.dircolors)"

# git prompt
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
GRAY=$(tput setaf 244)
RESET=$(tput sgr0)

git_prompt() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ "$BRANCH" ]]
  then
    GIT="\[$GREEN\]/ \[$YELLOW\]$BRANCH "
    if [[ "$(git status --short)" ]]; 
    then
        GIT="$GIT \[$GREEN\]/ \[$BLUE\]changed"
    fi
    echo $GIT
  else
    echo ""
  fi
}

export git_prompt
export PS0="\n"
export PS1="\n\[$RED\]\w \[$GREEN\]$(git_prompt)\n\[$GREEN\]| \[$RESET\]"
export PROMPT_COMMAND='PS1="\n\[$RED\]\w \[$GREEN\]$(git_prompt)\n\[$GREEN\]| \[$RESET\]"'

# git completion
. ~/.git-completion.bash

# init z
[[ -f $HOME/repo/other/z/z.sh ]] && . $HOME/repo/other/z/z.sh
