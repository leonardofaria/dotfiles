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
  font-fira-code
  font-hack-nerd-font
  font-meslo-for-powerline
  geekbench
  google-chrome
  iterm2
  rescuetime
  sourcetree
  spectacle
  spotify
  station
  the-unarchiver
  transmission
  tunnelblick
  visual-studio-code
  vlc
  yujitach-menumeters
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install betterzip qladdict quicklook-csv qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package qlvideo

# Creating Atom symlink
ln -s /Applications/Atom.app/Contents/Resources/app/atom.sh /usr/local/bin
