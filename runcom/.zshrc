# Enable Powerlevel10k instant prompt (must be at top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git npm macos zsh-autosuggestions brew)

source $ZSH/oh-my-zsh.sh

 # Make * work (ex: rm *.pdf)
 unsetopt NOMATCH
