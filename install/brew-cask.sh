if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Install packages

apps=(
  appcleaner
  atom
  coconutbattery
  docker
  firefox
  font-meslo-for-powerline
  gitify
  google-chrome
  iterm2
  launchrocket
  sequel-pro
  slack
  sourcetree
  spectacle
  spotify
  tableplus
  transmission
  visual-studio-code
  vlc
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package qlvideo

# Creating Atom symlink
ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin
