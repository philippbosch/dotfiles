export ZSH="$HOME/.oh-my-zsh"
typeset -U path fpath  # dedupe PATH entries

has() { (( $+commands[$1] )) }

# Homebrew (macOS)
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
fi
path=($HOME/.local/bin $path)

ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"

# Default zsh plugins
# zsh-syntax-highlighting must come last
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# sentry (must be on fpath before oh-my-zsh runs compinit)
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)

source $ZSH/oh-my-zsh.sh

# Aliases
source $HOME/.aliases

# Editor
export EDITOR=nvim

# Pure prompt
if [[ -d $HOME/.zsh/pure ]]; then
  fpath=($HOME/.zsh/pure $fpath)
  autoload -U promptinit; promptinit
  prompt pure
fi

# FZF
has fzf && source <(fzf --zsh)

# direnv
has direnv && eval "$(direnv hook zsh)"

# mise: node, python, ruby, java and global npm CLIs (config in ~/.config/mise/config.toml)
has mise && eval "$(mise activate zsh)"

# fnox
if has fnox; then
  export FNOX_AGE_KEY_FILE=~/.ssh/id_ed25519
  eval "$(fnox activate zsh)"
fi

# Android
if [[ -d $HOME/Library/Android/sdk ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  path=($ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/cmdline-tools/latest/bin $path)
fi
