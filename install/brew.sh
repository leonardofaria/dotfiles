if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Optional: in order to install brew for multiple users, create a group called brew.
# One way to create a group brew is to open the System Preferences and select Users & Groups.
# Unlock this screen and press the lower left +. Select the account type Group and name it brew.
# After creating this group add the users you want to share the brew apps
# Source: https://medium.com/@leifhanack/homebrew-multi-user-setup-e10cb5849d59

# sudo chgrp -R brew /usr/local/Caskroom
# sudo chmod -R g+w /usr/local/Caskroom
#
# sudo chgrp -R brew /usr/local/Cellar
# sudo chmod -R g+w /usr/local/Cellar
#
# sudo chgrp -R brew /usr/local/Homebrew
# sudo chmod -R g+w /usr/local/Homebrew
#
# sudo chgrp -R brew /Library/Caches/Homebrew
# sudo chmod -R g+w /Library/Caches/Homebrew

brew update
brew upgrade

# Install packages

apps=(
  ag
  bat
  bats
  dockutil
  duf
  dust
  exa
  ffmpeg
  git
  git-delta
  git-extras
  hh
  htop
  httpie
  imagemagick
  neofetch
  python3
  sqlite
  tree
  unar
  wget
  wifi-password
  yarn
)

for app in ${apps[*]}
  do
    brew install "${app}"
  done

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
