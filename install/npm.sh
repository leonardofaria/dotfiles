if ! is-executable brew -o ! is-executable git; then
  echo "Skipped: npm (missing: brew and/or git)"
  return
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export DOTFILES_BREW_PREFIX_NVM=`brew --prefix nvm`
set-config "DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_CACHE"

. "${DOTFILES_DIR}/system/.nvm"
nvm install stable
nvm alias default stable

# install bun as well
curl -fsSL https://bun.sh/install | bash

# and pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Globally install with npm
packages=(
  npm
  dockly
  fast-cli
  ffmpeg-progressbar-cli
  list-scripts
  macos-focus-mode
  npm-check-updates
  npm-scripts-tree
  script-list
  space-hogs
  @antfu/ni
)

pnpm install -g "${packages[@]}"
