# if ! is-executable brew -o ! is-executable git; then
#   echo "Skipped: npm (missing: brew and/or git)"
#   return
# fi

# if ! is-executable nvm; then
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
#   export DOTFILES_BREW_PREFIX_NVM=`brew --prefix nvm`
#   set-config "DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_CACHE"
#   . "${DOTFILES_DIR}/system/.nvm"
#   nvm install stable
#   nvm alias default stable
#   return
# fi

# # install bun as well
# if ! is-executable bun; then
#   curl -fsSL https://bun.sh/install | bash
#   return
# fi

# # and pnpm
# if ! is-executable pnpm; then
#   curl -fsSL https://get.pnpm.io/install.sh | sh -
#   return
# fi

# Globally install with pnpm
packages=(
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
