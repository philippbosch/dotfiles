#!/bin/bash

set -e

# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew tap caskroom/cask
brew cleanup

# Check Homebrew installation so far
brew doctor
read -p "Press Enter if the above looks ok, Ctrl-C otherwise."

# Install brews
brew bundle install
