ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git rails ruby npm macos zsh-autosuggestions nvm brew rvm)

source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

 # Make * work (ex: rm *.pdf)
 unsetopt NOMATCH
