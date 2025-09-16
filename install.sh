#!/bin/bash

# set -e

# Function to run commands with appropriate privileges
run_privileged() {
    if [ "$EUID" -eq 0 ]; then
        # Already running as root, no sudo needed
        "$@"
    elif command -v sudo &> /dev/null; then
        # Not root but sudo is available
        sudo "$@"
    else
        # Not root and sudo not available
        echo "Error: This script requires root privileges but sudo is not available."
        echo "Please run as root or install sudo."
        exit 1
    fi
}

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
    run_privileged apt update
    run_privileged apt install -y \
        zsh \
        neovim \
        fzf \
        npm \
        direnv \
        silversearcher-ag

    # Check fzf version and upgrade if needed
    REQUIRED_FZF_VERSION="0.48.0"
    CURRENT_VERSION=$(fzf --version | awk '{print $1}')
    if [ "$(printf '%s\n' "$REQUIRED_FZF_VERSION" "$CURRENT_VERSION" | sort -V | head -n1)" != "$REQUIRED_FZF_VERSION" ]; then
        run_privileged apt remove -y fzf
        echo "fzf $CURRENT_VERSION is < $REQUIRED_FZF_VERSION, installing newer version..."
        FZF_VERSION="0.56.3"
        wget -O /tmp/fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
        run_privileged tar -xzf /tmp/fzf.tar.gz -C /usr/local/bin
        rm /tmp/fzf.tar.gz
    else
        echo "fzf $CURRENT_VERSION is already >= $REQUIRED_FZF_VERSION"
    fi
fi
if [ "$OS" == "macos" ]; then
    brew update
    brew install \
        zsh \
        neovim \
        fzf \
        node \
        direnv \
        the_silver_searcher
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
run_privileged npm install -g diff-so-fancy

# Install Claude Code
run_privileged npm install -g @anthropic-ai/claude-code
