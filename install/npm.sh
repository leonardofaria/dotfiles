if ! is-executable brew -o ! is-executable git; then
  echo "Skipped: npm (missing: brew and/or git)"
  return
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export DOTFILES_BREW_PREFIX_NVM=`brew --prefix nvm`
set-config "DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_CACHE"

. "${DOTFILES_DIR}/system/.nvm"
nvm install stable
nvm alias default stable

# Globally install with npm

packages=(
  npm
  dockly
  ffmpeg-progressbar-cli
  list-scripts
  npm-check-updates
  npm-scripts-tree
  script-list
  see-cli
  space-hogs
  speed-test
)

npm install -g "${packages[@]}"
