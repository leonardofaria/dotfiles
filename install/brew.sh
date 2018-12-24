if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sudo chgrp -R brew /usr/local/Caskroom
sudo chmod -R g+w /usr/local/Caskroom

sudo chgrp -R brew /usr/local/Cellar
sudo chmod -R g+w /usr/local/Cellar

sudo chgrp -R brew /usr/local/Homebrew
sudo chmod -R g+w /usr/local/Homebrew

sudo chgrp -R brew /Library/Caches/Homebrew
sudo chmod -R g+w /Library/Caches/Homebrew

brew update
brew upgrade

# Install packages

apps=(
  ag
  bats
  dockutil
  ffmpeg
  git
  git-extras
  handbrake
  htop
  httpie
  hugo
  imagemagick
  mysql
  neofetch
  nginx
  postgresql
  python3
  sqlite
  tree
  unar
  wget
  wifi-password
  yarn
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
