# Installed by install.sh, or manually with: brew bundle --file=~/dotfiles/Brewfile
# Sign in to the App Store first so the `mas` entries can install.
# node, python, ruby and java come from mise, see home/.config/mise/config.toml

tap "getsentry/tools"
tap "heroku/brew"

# ─── Shell ─────────────────────────────────────────────────
brew "zsh"
brew "stow"          # links home/ into ~
brew "fzf"           # fuzzy finder
brew "direnv"        # per-directory env vars
brew "mise"          # runtime manager
brew "fnox"          # secrets
brew "age"

# ─── CLI basics ────────────────────────────────────────────
brew "eza"           # modern ls
brew "bat"           # cat with syntax highlighting
brew "ripgrep"       # fast grep (rg)
brew "jq"            # JSON processor
brew "mas"           # Mac App Store CLI

# ─── Git ───────────────────────────────────────────────────
brew "git"
brew "gh"            # GitHub CLI
brew "diff-so-fancy"
brew "git-lfs"

# ─── Editor ────────────────────────────────────────────────
brew "neovim"

# ─── Dev stack (Django / Expo / React) ─────────────────────
brew "uv"            # Python packages & venvs
brew "pnpm"
brew "watchman"      # React Native file watching
brew "postgresql@15"
brew "getsentry/tools/sentry-cli"
brew "heroku/brew/heroku"

# ─── Dev apps ──────────────────────────────────────────────
cask "claude"            # Claude Desktop
cask "ghostty"
cask "visual-studio-code"
cask "supacode"
cask "orbstack"          # Docker runtime (replaces Docker Desktop)
cask "android-studio"
cask "expo-orbit"
cask "figma"
cask "1password"         # also SSH agent + commit signing
cask "1password-cli"

# ─── Browsers ──────────────────────────────────────────────
cask "zen"
cask "google-chrome"
cask "velja"             # per-link browser routing

# ─── Productivity & communication ──────────────────────────
cask "raycast"
cask "slack"
cask "signal"
cask "telegram"
cask "toggl-track"
cask "spotify"
cask "logi-options+"

# ─── Mac App Store ─────────────────────────────────────────
mas "Xcode", id: 497799835
mas "Outbank", id: 1094255754
mas "WhatsApp", id: 310633997
