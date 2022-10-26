#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$HOME/.extra"

# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Update dotfiles itself first

if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

echo "➡️  Setting up symlinks"

ln -sfv "$DOTFILES_DIR/runcom/.gemrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
ln -sfv "$DOTFILES_DIR/runcom/.yarnrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.zprofile" ~
ln -sfv "$DOTFILES_DIR/runcom/.npmrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~
# This fix husky git hooks called inside Source Tree
ln -sfv "$DOTFILES_DIR/git/.huskyrc" ~

# Package managers & packages

echo "➡️  Setting up Brew"
. "$DOTFILES_DIR/install/brew.sh"

echo "➡️  Setting up Node/NPM"
. "$DOTFILES_DIR/install/npm.sh"

echo "➡️  Setting up Ruby"
. "$DOTFILES_DIR/install/ruby.sh"

echo "➡️  Setting up Mac things"
. "$DOTFILES_DIR/macos/defaults.sh"

echo "➡️  Setting up ZSH"
. "$DOTFILES_DIR/install/zsh.sh"

# Install extra stuff

if [ -d "$DOTFILES_EXTRA_DIR" -a -f "$DOTFILES_EXTRA_DIR/install.sh" ]; then
  . "$DOTFILES_EXTRA_DIR/install.sh"
fi
