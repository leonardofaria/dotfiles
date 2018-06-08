# .files

This is my quick dot files repo started on a Saturday night to make my new old MacBook Air looks like my old new MacBook. It is based in [webpro/dotfiles](https://github.com/webpro/dotfiles/) (you may want to check it out his repo to understand this one if you feel lost).

<img src="https://raw.githubusercontent.com/leonardofaria/dotfiles/master/screenshot.jpg" />

## How to use it?

- Clone the repo in your home directory: `git clone git@github.com:leonardofaria/dotfiles.git ~/.dotfiles`
- Run `./install.sh`

## What is installed?

### Installed via brew

> Check the description of the less popular apps

- [bats](http://brewformulas.org/Bats) - Bash Automated Testing System
- [dockutil](https://github.com/kcrawford/dockutil) - Command line tool for managing dock items
- [exa](https://the.exa.website/) - A modern replacement for `ls`
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
- atom
- coconutbattery
- docker
- firefox
- font-meslo-for-powerline
- geekbench
- gitify
- google-chrome
- iterm2
- launchrocket
- sequel-pro
- slack
- sourcetree
- spectacle
- spotify
- tableplus
- the-unarchiver
- transmission
- visual-studio-code
- vlc

### Other stuff also installed

- Node 8 via `nvm`
- Ruby 2.5.1 via `rvm`
- Oh my zsh, with [powerlevel9k](https://github.com/bhilburn/powerlevel9k) theme and git, rails, ruby, npm and osx plugins.

## Mac Defaults

There are lots of customizable Mac settings. Check `macos/defaults.sh` for all details.

### Dock items

You can update your dock running: `dotfiles dock`.

Note: this will remove all your current dock items.

## What is not done automatically

### Extra environment variables

Add your extra information environment variables in `system/.custom`.

### iTerm 2

Open Preferences and in General, check: "Load Preferences from a custom folder or URL". Point the folder to `macos` - There is a file there called `com.googlecode.iterm2.plist` with all setup.
