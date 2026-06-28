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
- showmd
- qlstephen
- qlvideo
- quicklook-csv
- suspicious-package
- webpquicklook

### Other stuff also installed

- Current Node via [mise](https://mise.jdx.dev/) (also installs pnpm and bun), with global packages:
  - [@antfu/ni](https://www.npmjs.com/package/@antfu/ni)
  - [dockly](https://www.npmjs.com/package/dockly)
  - [fast-cli](https://www.npmjs.com/package/fast-cli)
  - [ffmpeg-progressbar-cli](https://www.npmjs.com/package/ffmpeg-progressbar-cli)
  - [list-scripts](https://www.npmjs.com/package/list-scripts)
  - [macos-focus-mode](https://www.npmjs.com/package/macos-focus-mode)
  - [npm-check-updates](https://www.npmjs.com/package/npm-check-updates)
  - [npm-scripts-tree](https://www.npmjs.com/package/npm-scripts-tree)
  - [script-list](https://www.npmjs.com/package/script-list)
  - [space-hogs](https://www.npmjs.com/package/space-hogs)
- [Oh my zsh](https://github.com/robbyrussell/oh-my-zsh), with powerlevel10k theme and git, npm and osx plugins

## Mac Defaults

There are lots of customizable Mac settings. Check [`macos/defaults.sh`](https://github.com/leonardofaria/dotfiles/blob/master/macos/defaults.sh) for all details.

### Dock items

You can update your dock running: `dotfiles dock`.

Note: this will remove all your current dock items.

## What is not done automatically

### Extra environment variables

Add your extra information environment variables in `system/.custom`.

### VS Code / Cursor

Use the Sync Settings feature to restore settings from a different computer.

### Chrome

Recommended extensions:

- [Refined GitHub](https://chromewebstore.google.com/detail/refined-github/hlepfoohegkhhmjieoechaddaejaokhf)
- [Checker Plus for Gmail](https://chromewebstore.google.com/detail/checker-plus-for-gmail/oeopbcgkkoapgobdbedcemjljbihmemj)
- [Window Resizer](https://chromewebstore.google.com/detail/window-resizer/kkelicaakdanhinjdeammmilcgefonfh)
  - 1504 × 833 (window) — OBS, 1/4 of window
  - 1200 × 600 (viewport)
- [Gmail Sender Icons](https://chromewebstore.google.com/detail/gmail-sender-icons/jniljaamodclkmphgkgkooplflhkadpg)
- [File Icons for GitHub and GitLab](https://chromewebstore.google.com/detail/file-icons-for-github-and/ficfmibkjjnpogdcfhfokmihanoldbfe)
- [JSON Viewer Pro](https://chromewebstore.google.com/detail/json-viewer-pro/eifflpmocdbdmepbjaopkkhbfmdgijcc)
- [Wappalyzer](https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg)
- [Raindrop](https://chromewebstore.google.com/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien)
- [Control Panel for Twitter](https://chromewebstore.google.com/detail/control-panel-for-twitter/kpmjjdhbcfebfjgdnpjagcndoelnidfj)
- [Claude](https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn)
- [1Password](https://chromewebstore.google.com/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
- [Don't F\*\*\* With Paste](https://chromewebstore.google.com/detail/dont-f-with-paste/efaagigdgamehbpimpiagfpoihlkgamh)

### ssh keys

Run `ssh-keygen -t ed25519 -C "your_email@example.com"` - [More instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
