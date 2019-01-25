sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo 'ZSH_THEME="powerlevel9k/powerlevel9k"' >> ~/.zshrc

echo 'POWERLEVEL9K_MODE="nerdfont-complete"' >> ~/.zshrc
echo 'POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)' >> ~/.zshrc
echo 'POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator time)' >> ~/.zshrc
echo 'POWERLEVEL9K_PROMPT_ON_NEWLINE=true' >> ~/.zshrc
echo 'POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"' >> ~/.zshrc
echo 'POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "' >> ~/.zshrc

echo 'plugins=(git rails ruby npm osx)' >> ~/.zshrc

echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
