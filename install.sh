#!/bin/bash

# Detect OS
if [ "$(uname)" == "Darwin" ]; then
    OS="macos"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OS="linux"
else
    echo "Unsupported OS"
    exit 1
fi

# Install Homebrew
if [ "$OS" == "macos" ]; then
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi

# Add oh-my-zsh as a submodule
if [ ! -d home/oh-my-zsh ]
then
    git submodule add https://github.com/ohmyzsh/ohmyzsh.git home/oh-my-zsh
fi

# Update oh-my-zsh
git submodule update --init --recursive --remote

# Backup existing zshrc
if [ -f "$HOME/.zshrc" ]
then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Install pure prompt
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Link all files in home to the home directory
for file in $(ls home)
do
    if [[ -f "$HOME/.$file" ]]
    then
        echo "🚫 .$file exists. Skipping."
    else
        echo "🔗 Linking .$file"
        ln -s "$(pwd)/home/$file" "$HOME/.$file"
    fi
done

# Install some packages
if [ "$OS" == "macos" ]; then
    brew install --cask iterm2
    brew install --cask google-chrome
    brew install --cask slack
    brew install --cask spotify
    brew install --cask visual-studio-code
    brew install --cask cursor
fi

if [ "$OS" == "linux" ]; then
    sudo apt update
    sudo apt install -y neovim
fi