#!/bin/bash

install_essentials(){
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Terminal & Tools
  brew install ghostscript zsh zsh-completions zsh-autosuggestions #neofetch 
  brew install rename rsync ntfs-3g mas gotop pdfgrep yadm openssl wget exiftool rom-tools 
  #rom-tools for creating CHDs from CD-Roms PSX emulator 
  #htop #curl already comes with macOS

  # Dev
  brew install bat tree cmake go ctags meld #java # fzf installed via vim to ~/.fzf
  sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  #$(brew --prefix)/opt/fzf/install # install useful fzf key bindings and fuzzy completion for brew installed fzf
  brew install tmux git-flow perl latexdiff #node for npm webdev or youcompleteme plugin then #brew install sass/sass/sass
  #npm i @ayoisaiah/f2 -g #renaming tool (https://github.com/ayoisaiah/f2) if node is installed
  brew install --cask iterm2 vim ripgrep sublime-text docker mactex-no-gui skim zotero #mactex #java8 #sourcetree
  # brew install virtualbox virtualbox-extension-pack qemu

  # OS additions
  brew install --cask rectangle aerial itsycal cheatsheet
  # brew install --cask xquartz # Enable X11 Forwarding on Mac OS X (ssh -X host)

  # Findericons & Hammerspoon
  brew install fileicon
  brew install --cask hammerspoon openinterminal-lite openineditor-lite

  # General & Applications
  brew install --cask spotify google-backup-and-sync cyberduck raspberry-pi-imager #dropbox discord spotmenu
  brew install --cask osxfuse android-file-transfer android-platform-tools steam calibre vlc #eqmac has bug in catalina https://github.com/nodeful/eqMac2/issues/172
  #brew install --cask microsoft-remote-desktop # vnc-viewer (usually MacOS vnc tool should work: Spotlight "vnc.//")
  #brew install openconnect # Cisco Anyconnect alternative client

  # Privacy & Messaging
  brew install --cask gpg-suite tunnelblick protonvpn protonmail-bridge thunderbird firefox tor-browser #bitwarden #gnupg not needed with gpg-suite
  brew install --cask element signal
  brew install joplin
  
  # Work
  brew install --cask gotomeeting webex-meetings
  defaults write com.apple.finder AppleShowAllFiles YES
}

install_additionals(){
  brew install khanhas/tap/spicetify-cli
  brew install --cask ubersicht
  #git clone https://github.com/zhaorz/zenbar $HOME/Library/Application\ Support/Übersicht/widgets/zenbar
  git clone git@github.com:theuema/Uebersicht_Widgets.git $HOME/Library/Application\ Support/Übersicht/widgets
}

echo "\
MacEssentials Install Script

macOS Command Line Tools
Homebrew Package Manager

--- Terminal & Tools
brew: ghostscript zsh zsh-completions zsh-autosuggestions #neofetch 
brew: rename rsync ntfs-3g mas gotop pdfgrep yadm openssl wget exiftool #htop #curl already comes with macOS

--- Dev
brew: bat tree cmake go ctags #java # fzf installed via vim to ~/.fzf
brew: tmux git-flow perl latexdiff #node for npm webdev #brew install sass/sass/sass
cask: iterm2 vim ripgrep sublime-text docker mactex-no-gui skim zotero #mactex #java8 #sourcetree
additional casks:  # virtualbox virtualbox-extension-pack qemu
                   # openconnect # Cisco Anyconnect alternative client

--- OS additions
cask: rectangle aerial itsycal cheatsheet
additional casks: # xquartz # Enable X11 Forwarding on Mac OS X (ssh -X host)

--- Findericons & Hammerspoon
brew: fileicon
cask: hammerspoon openinterminal-lite openineditor-lite

--- General & Applications
cask: spotify google-backup-and-sync cyberduck raspberry-pi-imager #dropbox discord spotmenu
cask: osxfuse android-file-transfer steam calibre vlc #eqmac has bug in catalina https://github.com/nodeful/eqMac2/issues/172
additional casks: # microsoft-remote-desktop # vnc-viewer (usually MacOS vnc tool should work: Spotlight "vnc.//")
                  # openconnect # Cisco Anyconnect alternative client

--- Privacy & Messaging
cask: gpg-suite tunnelblick protonvpn protonmail-bridge thunderbird firefox tor-browser #bitwarden #gnupg not needed with gpg-suite
cask: element signal
brew: joplin

--- Work
cask: gotomeeting webex-meetings

Directly show hidden files in Finder: defaults write com.apple.finder AppleShowAllFiles YES
JR@DIG8216
"

# to install command line tools
xcode-select --install

answer=""
while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]; do
  echo "Do you want to install MacEssentials? (y/n)?"
  read answer
  if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    install_essentials

    echo "\
    Installation finished. Consider following information:

    You may now want to switch to iterm2 & install oh-my-zsh.
    - For you current .zshrc configuration you need:
    - > git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

    Dotfile installation with yadm is prefered after installing oh-my-zsh.
    - Dotfile info: fzf gets installed via vim.plug into ~/ (this is essential for a lot of dotfiles from yadm).
    - Dotfile info: vim.plug is automatically installed when starting vim via .vimrc.

    Don't forget to install virtualenvwrapper with pip3: $pip3 install virtualenvwrapper.

    MacOS: Adjust MissionContol shortcuts in settings. Therefore see settings_macOS.md file.

    Don't forget to set up ntfs-3g correctly: https://github.com/osxfuse/osxfuse/wiki/NTFS-3G#auto-mount-ntfs-volumes-in-read-write-mode-on-macos-1015-catalina

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
  Before you proceed, be sure that the .ssh folder is in place and dotfiles are synched!
  Also open the Spotify Application once.
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

echo "Finished."
