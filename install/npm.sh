if ! is-executable mise; then
  echo "Skipped: npm (missing: mise)"
  return
fi

eval "$(mise activate bash)"

mise use -g node@latest
mise use -g pnpm@latest
mise use -g bun@latest

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
