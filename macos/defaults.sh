# macOS defaults — compatible with macOS Tahoe (26.x)
# Based on https://github.com/webpro/dotfiles/blob/master/macos/defaults.sh
# More commands: https://macos-defaults.com/
#
# Some settings (Accessibility, Safari, Mail, Spotlight exclusions) require Full
# Disk Access for your terminal app. On Tahoe: System Settings → Privacy &
# Security → Full Disk Access → enable Terminal (or Cursor), then restart it.

# COMPUTER_NAME="MacLeozeraAir"

SKIPPED_DEFAULTS=()

# Write a default; collect failures instead of spamming stderr.
defaults_write() {
  if defaults write "$@" 2>/dev/null; then
    return 0
  fi
  SKIPPED_DEFAULTS+=("$*")
  return 1
}

# Write defaults for sandboxed apps (Safari, Mail).
write_sandboxed_defaults() {
  local app=$1
  shift
  if defaults write -app "$app" "$@" 2>/dev/null; then
    return 0
  fi
  SKIPPED_DEFAULTS+=("Safari/Mail: $*")
  return 1
}

# Close System Settings so open panes don't override scripted changes
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Settings → General → Sharing)
# sudo scutil --set ComputerName "$COMPUTER_NAME"
# sudo scutil --set HostName "$COMPUTER_NAME"
# sudo scutil --set LocalHostName "$COMPUTER_NAME"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Set standby delay to 24 hours (default is 1 hour)
# sudo pmset -a standbydelay 86400

# Disable audio feedback when volume is changed
# defaults write com.apple.sound.beep.feedback -bool false

# Disable the sound effects on boot
# sudo nvram SystemAudioVolume=" "

# Menu bar: disable transparency
# defaults write com.apple.universalaccess reduceTransparency -bool true

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Disable opening and closing window animations
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# LSQuarantine no longer disables Gatekeeper prompts (removed in Big Sur+).
# To skip quarantine on a specific download: xattr -d com.apple.quarantine /path/to/file

# Disable Resume system-wide
# defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
# defaults write com.apple.CrashReporter DialogType -string "none"

# Restart automatically if the computer freezes
# Error:-99 on stderr is a known Apple bug; the setting still applies.
sudo systemsetup -setrestartfreeze on 2>/dev/null

# Disable Notification Center (legacy launchctl syntax — prefer System Settings on Tahoe)
# launchctl bootout gui/$(id -u) /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Trackpad: swipe between pages with three fingers
# defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable access for assistive devices
# echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
# sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
# TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
# sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'

# Use scroll gesture with the Ctrl (^) modifier key to zoom
# Requires Full Disk Access for your terminal on Tahoe.
defaults_write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults_write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults_write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Required on Sequoia/Tahoe for custom key repeat rates to take effect
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate (logout/restart may be required)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en"
# defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
# sudo systemsetup -settimezone "Europe/Amsterdam" > /dev/null

# Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Stop Music from responding to the keyboard media keys
# launchctl bootout gui/$(id -u) /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in JPG format (other options: png, bmp, gif, pdf, tiff)
defaults write com.apple.screencapture type -string "jpg"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Font smoothing strength (mostly relevant for non-Retina external displays)
defaults write NSGlobalDomain AppleFontSmoothing -int 2

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
# defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default (also toggle with ⌘⇧.)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable the MacBook Air SuperDrive on any Mac
# sudo nvram boot-args="mbasd=1"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

###############################################################################
# Dock & Mission Control                                                      #
###############################################################################

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
# defaults write com.apple.dock launchanim -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# No bouncing icons
# defaults write com.apple.dock no-bouncing -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Hot corners                                                                 #
###############################################################################

# Possible values:
# 0: no-op
# 2: Mission Control
# 3: Show application windows
# 4: Desktop
# 5: Start screen saver
# 6: Disable screen saver
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left screen corner
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Display to sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
write_sandboxed_defaults Safari UniversalSearchEnabled -bool false
write_sandboxed_defaults Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
write_sandboxed_defaults Safari WebKitTabToLinksPreferenceKey -bool true
write_sandboxed_defaults Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar
write_sandboxed_defaults Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
write_sandboxed_defaults Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
write_sandboxed_defaults Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
write_sandboxed_defaults Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
write_sandboxed_defaults Safari ShowFavoritesBar -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
write_sandboxed_defaults Safari DebugSnapshotsUpdatePolicy -int 2

# Hide Safari’s sidebar in Top Sites
write_sandboxed_defaults Safari ShowSidebarInTopSites -bool false

# Remove useless icons from Safari’s bookmarks bar
write_sandboxed_defaults Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu, the Web Inspector, and the debug menu in Safari
write_sandboxed_defaults Safari IncludeInternalDebugMenu -bool true
write_sandboxed_defaults Safari IncludeDevelopMenu -bool true
write_sandboxed_defaults Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
write_sandboxed_defaults Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Display emails in threaded mode
write_sandboxed_defaults Mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"

# Disable send and reply animations in Mail.app
write_sandboxed_defaults Mail DisableReplyAnimations -bool true
write_sandboxed_defaults Mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>`
write_sandboxed_defaults Mail AddressesIncludeNameOnPasteboard -bool false

# Disable inline attachments (just show the icons)
write_sandboxed_defaults Mail DisableInlineAttachmentViewing -bool true

# Disable automatic spell checking
write_sandboxed_defaults Mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

# Disable sound for incoming mail
write_sandboxed_defaults Mail MailSound -string ""

# Disable sound for other mail actions
write_sandboxed_defaults Mail PlayMailSounds -bool false

# Mark all messages as read when opening a conversation
write_sandboxed_defaults Mail ConversationViewMarkAllAsRead -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight icon in the menu bar (⌘Space still works)
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1

# Disable Spotlight indexing for mounted volumes (optional; plist may not exist on Tahoe).
# To exclude /Volumes manually: System Settings → Siri & Spotlight → Spotlight Privacy → add /Volumes
for SPOTLIGHT_VOLUME_CONFIG in \
  "/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist" \
  "/.Spotlight-V100/VolumeConfiguration.plist"; do
  if [[ -f "$SPOTLIGHT_VOLUME_CONFIG" ]]; then
    if ! sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" "$SPOTLIGHT_VOLUME_CONFIG" 2>/dev/null | grep -q '/Volumes'; then
      sudo /usr/libexec/PlistBuddy -c "Add :Exclusions: string /Volumes/" "$SPOTLIGHT_VOLUME_CONFIG" 2>/dev/null \
        || SKIPPED_DEFAULTS+=("Spotlight volume exclusions (could not update plist)")
    fi
    break
  fi
done

# Change indexing order and disable some file types
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "CONTACT";}' \
	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}'

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use "Pro" theme (black background color)
# defaults write com.apple.terminal "Default Window Settings" -string "Pro"
# defaults write com.apple.terminal "Startup Window Settings" -string "Pro"

# Disable audible and visual bells
# defaults write com.apple.terminal "Bell" -bool false
# defaults write com.apple.terminal "VisualBell" -bool false

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Calendar" "Contacts" "ControlCenter" "Dock" "Finder" "Mail" "Safari"; do
  killall "${app}" &> /dev/null
done

if ((${#SKIPPED_DEFAULTS[@]} > 0)); then
  echo ""
  echo "⚠️  Some settings were skipped:"
  printf '   - %s\n' "${SKIPPED_DEFAULTS[@]}"
fi


# --- Touch ID for sudo ------------------------------------------------------
# Insert pam_tid.so above the required password module so a fingerprint
# short-circuits the password prompt. Idempotent. Note: macOS rewrites
# /etc/pam.d/sudo on major OS upgrades, so just re-run this script afterward.
if ! grep -q "pam_tid.so" /etc/pam.d/sudo; then
  echo "→ Enabling Touch ID for sudo..."
  sudo sed -i '' -e '/^auth[[:space:]]\{1,\}include[[:space:]]\{1,\}sudo_local/a\
auth sufficient pam_tid.so
' /etc/pam.d/sudo
else
  echo "→ Touch ID for sudo already enabled, skipping."
fi
