#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/TablePlus.app"
dockutil --no-restart --add "/System/Library/CoreServices/Applications/Screen Sharing.app"

dockutil --no-restart --add '~/Downloads' --view fan --display folder --sort name --allhomes
dockutil --no-restart --add '/Applications' --view grid --display folder --sort name --allhomes

killall Dock
