# .files

This is my quick dot files repo started on a Saturday night to make my new old MacBook Air looks like my old new MacBook. It is based in [webpro/dotfiles](https://github.com/webpro/dotfiles/) (you may want to check it out his repo to understand this one if you feel lost).

<img src="https://raw.githubusercontent.com/leonardofaria/dotfiles/master/screenshot.jpg" />

## How to use it?

- Make sure that you have an updated macOS and Command Line Tools for Xcode: `sudo softwareupdate -i -a && xcode-select --install`
- Clone the repo in your home directory: `cd ~ & git clone git@github.com:leonardofaria/dotfiles.git ~/.dotfiles`
- Run `./install.sh`

## What is installed?

### Installed via brew

Check `install/Brewfile` and `install/dev/Brewfile`

### Quick Look plugins

- betterzip
- qladdict
- qlcolorcode
- qlimagesize
- qlmarkdown
- qlstephen
- qlvideo
- quicklook-csv
- quicklook-json
- suspicious-package
- webpquicklook

### Other stuff also installed

- Current Node via `nvm`, with a few global packages:
  - [dockly](https://www.npmjs.com/package/dockly)
  - [list-scripts](https://www.npmjs.com/package/list-scripts)
  - [npm-check-updates](https://www.npmjs.com/package/npm-check-updates)
  - [npm-scripts-tree](https://www.npmjs.com/package/npm-scripts-tree)
  - [script-list](https://www.npmjs.com/package/script-list)
  - [space-hogs](https://www.npmjs.com/package/space-hogs)
  - [speed-test](https://www.npmjs.com/package/speed-test)
- Ruby 3 via `rvm`
- [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh), with powerlevel10k theme and git, rails, ruby, npm and osx plugins

## Mac Defaults

There are lots of customizable Mac settings. Check [`macos/defaults.sh`](https://github.com/leonardofaria/dotfiles/blob/master/macos/defaults.sh) for all details.

### Dock items

You can update your dock running: `dotfiles dock`.

Note: this will remove all your current dock items.

## What is not done automatically

### Extra environment variables

Add your extra information environment variables in `system/.custom`.

### iTerm 2

- Open Preferences and in General, check: "Load Preferences from a custom folder or URL". Point the folder to `macos` - There is a file there called `com.googlecode.iterm2.plist` with all setup.
- Import the file `macos/github-light-default.itermcolors` to get the GitHub colour scheme.

### VS Code

Use the Sync Settings feature to restore settings from a different computer.

### Chrome

Log in with a Google account to restore bookmarks, extensions, etc.

### ssh keys

Run `ssh-keygen -t ed25519 -C "your_email@example.com"` - [More instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
