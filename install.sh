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

# Install some packages
if [ "$OS" == "linux" ]; then
    sudo apt update
    sudo apt install -y zsh
    sudo apt install -y neovim
    sudo apt install -y fzf
    sudo apt install -y npm
fi
if [ "$OS" == "macos" ]; then
    brew update
    brew install zsh
    brew install neovim
    brew install fzf
    brew install node
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

mkdir -p "$HOME/.zsh"

# Link all files in home to the home directory
for file in $(ls home)
do
    if [[ -e "$HOME/.$file" ]]
    then
        echo "🚫 .$file exists. Skipping."
    else
        echo "🔗 Linking .$file"
        ln -s "$(pwd)/home/$file" "$HOME/.$file"
    fi
done

# Install pure prompt
if [ ! -d "$HOME/.zsh/pure" ]
then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install diff-so-fancy
sudo npm install -g diff-so-fancy

# Install some casks
if [ "$OS" == "macos" ]; then
    brew install --cask iterm2
    brew install --cask google-chrome
    brew install --cask slack
    brew install --cask spotify
    brew install --cask visual-studio-code
    brew install --cask cursor
fi
