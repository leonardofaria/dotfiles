#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Atom.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Sourcetree.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/TablePlus.app"

dockutil --no-restart --add '~/Downloads' --view fan --display folder --allhomes
dockutil --no-restart --add '/Applications' --view grid --display folder --allhomes

killall Dock
