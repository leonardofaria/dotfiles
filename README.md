# .files

This is my quick dot files repo created on a Saturday night to make my new old MacBook Air looks like my old new MacBook. It is based in [webpro/dotfiles](https://github.com/webpro/dotfiles/) (you may want to check it out his repo to understand this one if you feel lost).

## How to use it?

- Clone the repo in your home directory: `git clone git@github.com:leonardofaria/dotfiles.git ~/.dotfiles`
- Run `./install.sh`

## What is installed?

### Installed via brew

- bats
- dockutil
- ffmpeg
- git
- git-extras
- htop
- httpie
- imagemagick
- mysql
- neofetch
- nginx
- python3
- sqlite
- tree
- unar
- wget
- wifi-password
- yarn

### Installed via brew cask

- appcleaner
- atom
- docker
- firefox
- font-meslo-for-powerline
- google-chrome
- iterm2
- launchrocket
- sequel-pro
- slack
- sourcetree
- spectacle
- spotify
- tableplus
- transmission
- visual-studio-code
- vlc

### Other stuff also installed

- Node 8 via `nvm`
- Ruby 2.4.1 via `rvm`
- Oh my zsh!

## Mac Defaults

There are lots of customizable Mac settings. Check `macos/defaults.sh`

## What is not done automatically

### Extra environment variables

Add your extra information environment variables in `system/.custom`.

### iTerm 2

Open Preferences and in General, check: "Load Preferences from a custom folder or URL". Point the folder to `macos` - There is a file there called `com.googlecode.iterm2.plist` with all setup.
