ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git npm macos zsh-autosuggestions brew rvm)

source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

 # Make * work (ex: rm *.pdf)
 unsetopt NOMATCH
