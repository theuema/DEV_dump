#!/bin/bash

if ! ping -q -c 1 -W 1 google.com >/dev/null;
then
  echo "Network down."
  read -rsp $'Press any key to exit ...\n' -n1 key
  exit
fi

full=""
while [[ "$full" != "n" && "$full" != "y" && "$full" != "N" && "$full" != "Y" ]]
do
  echo "\
  --- Standard upgrade:
      Brew Formulas, Brew Casks
      [Optional: no_versioning Casks, Appstore applications, & macOS system software]

  --- Full system upgrade:
      Brew Formulas, Brew Casks (+no_versioning), Appstore applications, & macOS system software

  Perform full system upgrade? (y/n)
  "
  read full
  if [ "$full" == "y" ]
  then
    echo "Performing full system upgrade ..."
  fi
done

echo "--- Brew update ..."
brew update

# ========
# Formulas
# ========

echo "--- Upgrade Brews ..."
brew upgrade --formula
brew missing

# ===========================
# Casks & no_versioning Casks
# ===========================

echo "--- Upgrade Casks ..."
brew upgrade --cask

if [ "$full" == "y" ]
then
  echo "Upgrade auto_update and no_versioning casks ..."
  brew upgrade --cask --greedy
else
  answer=""
  while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]
  do
    echo "Do you want to upgrade auto_update and no_versioning Casks? (y/n)"
    read answer

    if [ "$answer" == "y" ]
    then
      brew upgrade --cask --greedy # upgrade no_versioning & apps with auto_update mechanism
    fi
  done
fi

echo "--- Cleanup Homebrew ..."
brew cleanup -s
brew doctor

# =====================
# Appstore Applications
# =====================

if [ "$full" == "y" ]
then
  echo "--- Upgrade Appstore Applications ..."
  masOutput=$(mas outdated 2>&1)

  if [ "$masOutput" != "" ]
  then
    mas upgrade
  fi
else
  echo "--- Upgrade Appstore Applications ..."
  masOutput=$(mas outdated 2>&1)

  if [ "$masOutput" != "" ]
  then
    echo "$masOutput"
    answer=""
    while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]
    do
      echo "Do you want to upgrade? (y/n)"
      read answer
      if [ "$answer" == "y" ]
      then
        mas upgrade
      fi
    done
  fi
fi

# =====================
# macOS System Software
# =====================

if [ "$full" == "y" ]
then
  echo "--- Update macOS System Software ..."
  softwareupdateOutput=$(softwareupdate -l 2>&1)

  if [[ $softwareupdateOutput != *"No new software available."* ]]
  then
    softwareupdate -ia
  fi
else
  echo "--- Update macOS System Software ..."
  softwareupdateOutput=$(softwareupdate -l 2>&1)
  echo "$softwareupdateOutput"
  if [[ $softwareupdateOutput != *"No new software available."* ]]
  then
    answer=""
    while [[ "$answer" != "n" && "$answer" != "y" && "$answer" != "N" && "$answer" != "Y" ]]
    do
      echo "Do you want to update? (y/n)"
      read answer
      if [ "$answer" == "y" ]
      then
        softwareupdate -ia
      fi
    done
  fi
fi

read -rsp $'Press any key to finish ...\n' -n1 key
