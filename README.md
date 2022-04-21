# .files

This is my quick dot files repo started on a Saturday night to make my new old MacBook Air looks like my old new MacBook. It is based in [webpro/dotfiles](https://github.com/webpro/dotfiles/) (you may want to check it out his repo to understand this one if you feel lost).

<img src="https://raw.githubusercontent.com/leonardofaria/dotfiles/master/screenshot.jpg" />

## How to use it?

- Make sure that you have an updated macOS and Command Line Tools for Xcode: `sudo softwareupdate -i -a && xcode-select --install`
- Clone the repo in your home directory: `cd ~ & git clone git@github.com:leonardofaria/dotfiles.git ~/.dotfiles`
- Run `./install.sh`

## What is installed?

### Installed via brew

> Check the description of the less popular apps

- ag
- [bats](http://brewformulas.org/Bats) - Bash Automated Testing System
- [dockutil](https://github.com/kcrawford/dockutil) - Command line tool for managing dock items
- ffmpeg
- git
- git-extras
- htop
- [httpie](https://github.com/jakubroztocil/httpie) - A Modern command line HTTP client
- hugo
- imagemagick
- mysql
- [neofetch](https://github.com/dylanaraps/neofetch) - A command-line system information tool
- nginx
- postgresql
- python3
- sqlite
- tree
- [unar](https://theunarchiver.com/command-line) - A easy way for unarchiving files
- wget
- wifi-password
- yarn

### Installed via brew cask

> Using brew cask to install Mac app definitely save you a couple hours of browsing

- appcleaner
- android-platform-tools
- atom
- chromedriver
- coconutbattery
- docker
- dropbox
- firefox
- font-fira-code
- font-hack-nerd-font
- font-meslo-for-powerline
- geekbench
- gitify
- google-chrome
- iterm2
- rescuetime
- sequel-pro
- slack
- sourcetree
- spectacle
- spotify
- station
- tableplus
- the-unarchiver
- transmission
- visual-studio-code
- vlc
- yujitach-menumeters

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
  - [see-cli](https://github.com/rwu823/see-cli)
  - [space-hogs](https://www.npmjs.com/package/space-hogs)
  - [speed-test](https://www.npmjs.com/package/speed-test)
- Ruby 2.5.1 via `rvm`
- [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh), with [powerlevel9k](https://github.com/bhilburn/powerlevel9k) theme and git, rails, ruby, npm and osx plugins

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
