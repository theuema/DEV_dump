#!/bin/bash

# Pre-requirements
# Install command line tools and rosetta
# xcode-select --install
# if [ "$(arch)" = "arm64" ]; then
#     /usr/sbin/softwareupdate --install-rosetta --agree-to-license

# Install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap casks
# brew tap homebrew/cask

# Set up terminal workflow
# brew install zsh zsh-completions zsh-autosuggestions

install_essentials(){
  # Terminal & Tools
  #brew install neofetch
  brew install rename rsync mas gotop pdfgrep yadm openssl wget exiftool rom-tools #ntfs-3g #ghostscript #rom-tools for creating CHDs from CD-Roms PSX emulator 
  #brew install htop curl #htop -gotop alternative #curl -to use newer curl version from brew

  # Dev
  brew install bat vim tree go meld #cmake #ctags #java #fzf -installed via vim to ~/.fzf
  brew install --cask macfuse
  brew install gromgit/fuse/sshfs-mac #brew install sshfs replacement due to macfuse not being open source anymore; see https://docs.brew.sh/Interesting-Taps-and-Forks  
  # sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  brew install tmux git-flow perl latexdiff #node -for npm webdev or youcompleteme plugin then: brew install sass/sass/sass
  #npm i @ayoisaiah/f2 -g #renaming tool (https://github.com/ayoisaiah/f2) if node is installed
  brew install --cask iterm2 ripgrep docker sublime-text visual-studio-code mactex-no-gui skim zotero #mactex #java8 #sourcetree
  # brew install virtualbox virtualbox-extension-pack qemu

  # OS additions
  brew install --cask rectangle cheatsheet #itsycal -use widget in macOS Monterey #aerial -screensaver 
  brew install --cask xquartz # Enable X11 Forwarding on macOS (ssh -Y host)

  # Findericons & Hammerspoon
  # brew install fileicon
  # brew install --cask hammerspoon openinterminal-lite openineditor-lite

  # General & Applications
  brew install --cask spotify google-drive cyberduck raspberry-pi-imager #dropbox discord spotmenu
  brew install --cask android-file-transfer android-platform-tools steam calibre vlc #eqmac -bug in catalina https://github.com/nodeful/eqMac2/issues/172
  brew install --cask microsoft-remote-desktop #vnc-viewer -usually macOS vnc tool works: Spotlight "vnc.//")
  brew install openconnect # Cisco anyconnect alternative CLI client

  # Privacy & Messaging
  brew install --cask gpg-suite protonvpn protonmail-bridge thunderbird firefox tor-browser #tunnelblick #bitwarden -better install directly
  brew install --cask element signal
  brew install --cask joplin
  
  # Remote meetings
  brew install --cask gotomeeting webex-meetings
}

install_additionals(){
  brew install khanhas/tap/spicetify-cli
  brew install --cask ubersicht
  #git clone https://github.com/zhaorz/zenbar $HOME/Library/Application\ Support/Übersicht/widgets/zenbar
  git clone git@github.com:theuema/Uebersicht_Widgets.git $HOME/Library/Application\ Support/Übersicht/widgets
}

echo "\
MacEssentials install script

--- ! Pre-requirements !

# Install command line tools and rosetta
# xcode-select --install
# if [ "$(arch)" = "arm64" ]; then
#     /usr/sbin/softwareupdate --install-rosetta --agree-to-license

# Install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tap casks
# brew tap homebrew/cask

# Set up terminal workflow
# brew install zsh zsh-completions zsh-autosuggestions

--- ! Essential Installations !

# Terminal & Tools
brew install zsh zsh-completions zsh-autosuggestions #neofetch #ghostscript
brew install rename rsync ntfs-3g mas gotop pdfgrep yadm openssl wget exiftool rom-tools #rom-tools for creating CHDs from CD-Roms PSX emulator 
#htop -gotop alternative #curl -to use newer curl version from brew

# Dev
brew install bat tree go meld #cmake #ctags #java #fzf -installed via vim to ~/.fzf
# sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
#$(brew --prefix)/opt/fzf/install #install useful fzf key bindings and fuzzy completion for brew installed fzf
brew install tmux git-flow perl latexdiff #node -for npm webdev or youcompleteme plugin then: brew install sass/sass/sass
#npm i @ayoisaiah/f2 -g #renaming tool (https://github.com/ayoisaiah/f2) if node is installed
brew install --cask iterm2 vim ripgrep sublime-text docker mactex-no-gui skim zotero #mactex #java8 #sourcetree
# brew install virtualbox virtualbox-extension-pack qemu

# OS additions
brew install --cask rectangle cheatsheet #itsycal -use widget in macOS Monterey #aerial -screensaver 
brew install --cask xquartz # Enable X11 Forwarding on macOS (ssh -Y host)

# Findericons & Hammerspoon
# brew install fileicon
# brew install --cask hammerspoon openinterminal-lite openineditor-lite

# General & Applications
brew install --cask spotify google-drive cyberduck raspberry-pi-imager #dropbox discord spotmenu
brew install --cask osxfuse android-file-transfer android-platform-tools steam calibre vlc #eqmac -bug in catalina https://github.com/nodeful/eqMac2/issues/172
brew install --cask microsoft-remote-desktop #vnc-viewer -usually macOS vnc tool works: Spotlight "vnc.//")
brew install openconnect # Cisco anyconnect alternative CLI client

# Privacy & Messaging
brew install --cask gpg-suite protonvpn protonmail-bridge thunderbird firefox tor-browser #tunnelblick #bitwarden -better install directly
brew install --cask element signal
brew install --cask joplin

# Remote meetings
brew install --cask gotomeeting webex-meetings
"

answer=""
while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]; do
  echo "Do you want to install MacEssentials? (y/n)?"
  read answer
  if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    install_essentials

    echo "\
    Installation finished. Consider following information:

    Switch to iTerm2 & install oh-my-zsh.
    - recommended iTerm2 theme:
    - > git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

    Dotfile installation with yadm is prefered after installing oh-my-zsh
    Dotfiles: git@github.com:theuema/dotfiles.git
    - Dotfile info: fzf is installed via vim.plug to $HOME
    - Dotfile info: vim.plug is automatically installed when starting vim with .vimrc

    Install virtualenvwrapper if needed ($pip3 install virtualenvwrapper)

    macOS settings: Adjust MissionContol shortcuts in settings (see Joplin)

    If ntfs is needed: set up _ntfs-3g_ correctly: https://github.com/osxfuse/osxfuse/wiki/NTFS-3G#auto-mount-ntfs-volumes-in-read-write-mode-on-macos-1015-catalina

    Done.
  "
  fi
done

echo "" 
echo "\
MacAdditionals Install Script

brew: khanhas/tap/spicetify-cli
cask: ubersicht
git clone git@github.com:theuema/Uebersicht_Widgets.git $HOME/Library/Application\ Support/Übersicht/widgets

"

answer=""
while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]; do
  echo "\
  Before you proceed open the spotify application once.
  Do you also want to install additionals? (y/n)?
  "
  read answer
  if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    install_additionals
    echo "Installation finished. Consider following information: "
    echo "\
    Configure spotify custom theme with the following commands:
      > spicetify
      > spicetify backup apply enable-devtool
      > spicetify update
      > git clone git@github.com:theuema/spicetify-themes.git ~/spicetify_data/Themes 
      > spicetify config current_theme Pop-Dark
      > spicetify apply
      
      Done.
      "
  fi
done

# Additional OS settings.
defaults write com.apple.finder AppleShowAllFiles YES

echo "Essentials installation finished."
