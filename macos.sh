#!/usr/bin/env bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# [Network] Set computer name.
sudo scutil --set ComputerName "wavded"
sudo scutil --set HostName "wavded"
sudo scutil --set LocalHostName "wavded"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "wavded"

# [System] Disable the sound effects on boot.
sudo nvram SystemAudioVolume=" "

# [System] Disable the over-the-top focus ring animation.
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# [System] Adjust toolbar title rollover delay.
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# [System] Increase window resize speed for Cocoa applications.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# [System] Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# [System] Expand print panel by default.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# [System] Save to disk (not to iCloud) by default.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# [System] Disable the “Are you sure you want to open this application?” dialog.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# [System] Disable Resume.
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# [System] Disable automatic termination of inactive apps.
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# [System] Disable guest account
defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO

# [Auto-correct] Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# [Auto-correct] Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# [Auto-correct] Disable automatic period substitution.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# [Auto-correct] Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# [Auto-correct] Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# [Trackpad] Enable tap to click.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# [Keyboard] Enable full keyboard access for all controls.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# [Keyboard] Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# [Keyboard] Set a fast keyboard repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# [Screen Saver] Require password immediately.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# [Screenshots] Save to the desktop.
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# [Screenshots] Save screenshots in PNG format.
defaults write com.apple.screencapture type -string "png"

# [Screenshots] Disable shadow.
defaults write com.apple.screencapture disable-shadow -bool true

# [Finder] Allow quitting via ⌘ + Q.
defaults write com.apple.finder QuitMenuItem -bool true

# [Finder] Disable window animations and Get Info animations.
defaults write com.apple.finder DisableAllAnimations -bool true

# [Finder] Set Desktop as the default location for new windows.
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# [Finder] Show icons for drives, servers, and removable media on Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# [Finder] Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# [Finder] Display full POSIX path as Finder window title.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# [Finder] Keep folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# [Finder] When performing a search, search the current folder by default.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# [Finder] Disable the warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# [Finder] Avoid creating .DS_Store files on network or USB volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# [Finder] Disable disk image verification.
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# [Finder] Automatically open a new window when a volume is mounted.
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# [Finder] Use column view in all Finder windows by default.
defaults write com.apple.finder FXPreferredViewStyle -string "clsv"

# [Finder] Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# [Finder] Enable AirDrop over Ethernet.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# [Finder] Show the ~/Library folder
chflags nohidden ~/Library

# [Finder] Show the /Volumes folder
sudo chflags nohidden /Volumes

# [Finder] Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# [Dock] Set the icon size to 48 pixels.
defaults write com.apple.dock tilesize -int 52

# [Dock] Change minimize/maximize window effect, faster.
defaults write com.apple.dock mineffect -string "scale"

# [Dock] Minimize windows into their application’s icon.
defaults write com.apple.dock minimize-to-application -bool true

# [Dock] Enable spring loading for all items.
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# [Dock] Show indicator lights for open applications.
defaults write com.apple.dock show-process-indicators -bool true

# [Dock] Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# [Dock] Speed up Mission Control animations.
defaults write com.apple.dock expose-animation-duration -float 0.1

# [Dock] Don’t automatically rearrange Spaces based on most recent use.
defaults write com.apple.dock mru-spaces -bool false

# [Dock] Remove the auto-hiding delay.
defaults write com.apple.dock autohide-delay -float 0

# [Dock] Remove the animation when hiding/showing.
defaults write com.apple.dock autohide-time-modifier -float 0

# [Dock] Automatically hide and show.
defaults write com.apple.dock autohide -bool true

# [Dock] Make hidden applications translucent.
defaults write com.apple.dock showhidden -bool true

# [Dock] Don’t show recent applications.
defaults write com.apple.dock show-recents -bool false

# [Hot Corners] Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# [Hot Corners] Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# [Safari] Don’t send search queries to Apple.
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# [Safari] Press Tab to highlight each item on a web page.
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# [Safari] Show the full URL in the address bar.
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# [Safari] Set home page to `about:blank` for faster loading.
defaults write com.apple.Safari HomePage -string "about:blank"

# [Safari] Allow hitting the Backspace key to go to the previous page in history.
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# [Safari] Hide bookmarks bar by default.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# [Safari] Hide sidebar in Top Sites.
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# [Safari] Enable the Develop menu and Web Inspector.
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# [Safari] Enable continuous spellchecking.
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# [Safari] Disable auto-correct.
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# [Safari] Disable AutoFill.
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# [Safari] Warn about fraudulent websites.
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# [Safari] Disable plug-ins.
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# [Safari] Disable Java.
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# [Safari] Block pop-up windows.
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# [Safari] Enable "Do Not Track".
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# [Safari] Update extensions automatically.
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# [Spotlight] Change indexing order and disable some search results.
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
killall mds > /dev/null 2>&1
sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null

# [iTerm2] Don’t display the exit prompt.
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# [Activity Monitor] Show all processes.
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# [TextEdit] Use plain text mode for new TextEdit documents.
defaults write com.apple.TextEdit RichText -int 0

# [TextEdit] Open and save files as UTF-8 in TextEdit.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# [Software Update] Enable automatic update check.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# [Software Update] Check for software updates daily.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# [Software Update] Download newly available updates in background.
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# [Software Update] Auto-install system data files & security updates.
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# [App Store] Turn on app auto-update.
defaults write com.apple.commerce AutoUpdate -bool true

# [App Store] Allow reboot machine on macOS updates.
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

# [Chrome] Disable backswipe guestures.
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
