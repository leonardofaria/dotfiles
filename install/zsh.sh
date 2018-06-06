sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

echo 'ZSH_THEME="powerlevel9k/powerlevel9k"' >> ~/.zshrc

echo 'POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)' >> ~/.zshrc
echo 'POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)' >> ~/.zshrc

echo 'plugins=(git rails ruby npm osx)' >> ~/.zshrc

echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
