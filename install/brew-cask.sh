if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap homebrew/cask-versions
brew tap homebrew/cask
brew tap homebrew/cask-fonts

# Install packages
apps=(
  1password
  appcleaner
  coconutbattery
  # docker
  ferdi
  font-fira-code
  font-hack-nerd-font
  font-meslo-for-powerline
  geekbench
  google-chrome
  hiddenbar
  iterm2
  karabiner-elements
  menumeters
  rectangle
  rescuetime
  sequel-pro
  slack
  sourcetree
  spotify
  tableplus
  the-unarchiver
  transmission
  tunnelblick
  visual-studio-code
  vlc
)

for app in ${apps[*]}
  do
    brew install --cask "${app}"
  done

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
plugins=(
  betterzip
  qladdict
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlstephen
  qlvideo
  quicklook-csv
  quicklook-json
  suspicious-package
  webpquicklook
)

for plugin in ${plugins[*]}
  do
    brew install --cask "${plugin}"
  done
