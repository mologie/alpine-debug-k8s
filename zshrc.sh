export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

: ${ZSH:=/usr/local/share/oh-my-zsh}
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
ZSH_THEME="ys"
COMPLETION_WAITING_DOTS="true"
plugins=(fzf zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

setopt histignorespace
alias k="kubectl"
alias q="exit"
