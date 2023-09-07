#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# sources & inspirations :
# https://github.com/avelino/dotfiles/blob/main/macos.install.sh

echo "> closing system preferences"
osascript -e 'tell application "System Preferences" to quit'

echo "> installing xcode"
xcode-select --install

echo "> updating macos"
softwareupdate --install -a

if [[ $(uname -m) == 'arm64' ]]; then
    echo "> installing rosetta"
    softwareupdate --install-rosetta --agree-to-license
fi

echo "> installing homebrew"
if ! [ -x "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "> Show remaining % battery"
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

echo "> Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

echo "> Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "> Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "> Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "> Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "> Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "> Remove duplicates in the 'Open With' menu (also see lscleanup alias)"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

echo "> Display ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

echo "> Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "> Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true

echo "> Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "> Disable Notification Center and remove the menu bar icon"
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

echo "> Disable automatic capitalization as it's annoying when typing code"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo "> Disable smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "> Disable automatic period substitution as it's annoying when typing "code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "> Disable smart quotes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "> Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "> Stop iTunes from responding to the keyboard media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

echo "> Trackpad: Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "> Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "> Trackpad: enable right click with two fingers"
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture 1

echo "> Trackpad: enable zoom"
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch 1
# TODO mission control swipe up three fingers

echo "> MissionControl: set fast animation speed"
defaults write com.apple.Dock expose-animation-duration -float 0.1

# TODO show desktop spread thumb 3 fingers
echo "> Trackpad: launch Exposé with three fringers swiping down"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture = 2

echo "> Trackpad: swipe with three fingers horizontaly to switch full-screen apps"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture = 2

echo "> Trackpad: launchpad pinch thumb and 3 fingers"
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture 2

echo "> Keyboard: Enable full keyboard access for all controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "> Keyboard: Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "> Keyboard: Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "> Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "> Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "> Save screenshots in JPG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "jpg"

echo "> Enable subpixel font rendering on non-Apple LCDs"
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

echo "> Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

echo "> Finder: allow quitting via ⌘ + Q; doing so will also hide desktop "icons
defaults write com.apple.finder QuitMenuItem -bool true

echo "> Set Home as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "> Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "> Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "> Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "> Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "> Finder: Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "> Finder: When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "> Finder: Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "> Finder: Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "> Finder: Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo "> Finder: Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "> Finder: Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "> Finder: Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "> Finder: Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false# Show the ~/Library folder
chflags nohidden ~/Library

echo "> Finder: Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "> Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "> Expand the following File Info panes: 'General', 'Open with', and 'Sharing & Permissions'"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

echo "> Edit hot corners"
# Possible values: tl/tr/bl/br
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
echo "> Hot corners: bottom right screen corner -> Start screen saver"
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

echo "> Dock: Show indicator lights for open applications"
defaults write com.apple.dock show-process-indicators -bool true

echo "> Dock: Minimize windows into their application's icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "> Dock: Don't animate opening applications"
defaults write com.apple.dock launchanim -bool false

echo "> Dock: Enable spring loading"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

echo "> Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "> Don't show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "> Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "> Dock: Don't show recent applications"
defaults write com.apple.dock show-recents -bool false

echo "> Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "> Don't group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

echo "> Change minimize/maximize window effect to genie"
defaults write com.apple.dock mineffect -string "genie"

echo "> Privacy: don't send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "> Safari: Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

echo "> Safari: Show the full URL in the address bar (note: this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "> Safari: Set home page to about:blank for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "> Safari: prevent opening 'safe' files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "> Safari: show bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool true

echo "> Safari: Hide sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "> Safari: Disable thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "> Safari: Enable debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "> Safari: Make search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "> Safari: Remove useless icons from bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "> Safari: Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "> Safari: Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "> Safari: Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

echo "> Safari: Enable 'Do Not Track'"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "> Safari: Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

echo "> Mail: Disable send and reply animations"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

echo "> Mail: Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "> Mail: Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo "> Mail: Disable automatic spell checking"
defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

echo "> Spotlight: Hide tray-icon (and subsequent helper)"
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

echo "> Time Machine: Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "> Time Machine: Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal

echo "> ActivityMonitor: Show the main window when launching"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo "> ActivityMonitor: Visualize CPU usage in the Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo "> ActivityMonitor: Show all processes"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "> ActivityMonitor: Sort results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

echo "> AddressBook: Enable the debug menu"
defaults write com.apple.addressbook ABShowDebugMenu -bool true

echo "> Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true

echo "> iCal: Enable the debug menu(pre-10.8)"
defaults write com.apple.iCal IncludeDebugMenu -bool true

echo "> TextEdit: Use plain text mode for new documents"
defaults write com.apple.TextEdit RichText -int 0
echo "> TextEdit: Open and save files as UTF-8"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

echo "> DiskUtility: Enable the debug menu"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

echo "> MacAppStore: Enable the WebKit Developer Tools"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo "> MacAppStore: Enable Debug Menu"
defaults write com.apple.appstore ShowDebugMenu -bool true

echo "> Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo "> Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "> Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

echo "> Install System data files & security updates"
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

echo "> Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

echo "> GoogleChrome: Disable the all too sensitive backswipe on trackpads"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

echo "> GoogleChrome: Disable the all too sensitive backswipe on Magic Mouse"
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

echo "> GoogleChrome: Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true

echo "> GoogleChrome: Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

echo "> Photos: Prevent opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "> Terminal: Only use UTF-8"
defaults write com.apple.terminal StringEncodings -array 4

echo "> Terminal: Enable Secure Keyboard Entry"
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

echo "> Terminal: Disable the annoying line marks"
defaults write com.apple.Terminal ShowLineMarks -int 0

echo "> Don't display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

echo "> Messages: Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "macos first install done - please reboot"
