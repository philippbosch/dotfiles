#!/bin/bash

# set -e

# Always operate relative to the repo, regardless of where the script is run from
cd "$(dirname "$0")" || exit 1

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

# Make tools installed by this script usable within the same run,
# regardless of the shell it was started from
export PATH="$HOME/.local/bin:$PATH"
load_brew() {
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

# Install Homebrew
if [ "$OS" == "macos" ]; then
    load_brew
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        load_brew
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
        stow \
        ripgrep

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

    for tap in getsentry/tools heroku/brew uberblick-ai/tap; do
        brew tap "$tap" && brew trust "$tap"
    done

    brew bundle --file=Brewfile

    # Point the developer directory at full Xcode (the Homebrew installer
    # selects the Command Line Tools, which breaks xcodebuild and Expo builds)
    XCODE_DEV=/Applications/Xcode.app/Contents/Developer
    if [ -d "$XCODE_DEV" ]; then
        if [ "$(xcode-select -p 2>/dev/null)" != "$XCODE_DEV" ]; then
            run_privileged xcode-select -s "$XCODE_DEV"
        fi
        # Accepting the license is a no-op if it's already accepted
        run_privileged xcodebuild -license accept
        xcodebuild -runFirstLaunch
        if ! xcrun simctl list runtimes 2>/dev/null | grep -q '^iOS'; then
            echo "Downloading the iOS platform and simulator (several GB)..."
            xcodebuild -downloadPlatform iOS
        fi
    else
        echo "⚠️  Xcode not found in /Applications; re-run install.sh once it's installed."
    fi
fi

# Fetch submodules at the commits pinned in this repo
git submodule update --init --recursive

mkdir -p "$HOME/.zsh"

# Create these as real directories so stow links the files inside them
# instead of turning the whole directory into a symlink into this repo
mkdir -p "$HOME/.config" "$HOME/.ssh" && chmod 700 "$HOME/.ssh"

# Link everything in home/ into ~. Stow never overwrites existing files:
# on conflicts, either remove them or run `stow --adopt -t ~ home` to pull
# them into the repo, then review with `git diff`.
if ! stow -t "$HOME" --restow home; then
    echo "🚫 stow found conflicting files in ~ (see above). Resolve them and re-run."
    exit 1
fi

# Clone public repos without ~/.gitconfig: it rewrites GitHub URLs to SSH,
# which needs the 1Password SSH agent and isn't set up yet on a fresh machine
clone_public() {
    GIT_CONFIG_GLOBAL=/dev/null git clone "$@"
}

# Install pure prompt
if [ ! -d "$HOME/.zsh/pure" ]
then
    clone_public https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
then
    clone_public https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
    clone_public https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install language runtimes and global CLIs from ~/.config/mise/config.toml
if command -v mise &> /dev/null; then
    mise install
fi

# Install diff-so-fancy (comes from the Brewfile on macOS)
if [ "$OS" == "linux" ]; then
    run_privileged npm install -g diff-so-fancy
fi

# Install Claude Code (native installer, auto-updates)
if [ ! -x "$HOME/.local/bin/claude" ]; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

echo
echo "✅ Done. Open a new terminal (or run: exec zsh) to load the new shell config."
