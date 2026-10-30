# dotfiles

Shell, git, SSH and editor config for macOS (Linux partially supported).

## Install

```sh
git clone git@github.com:philippbosch/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh`:

1. Installs Homebrew and the packages in [`Brewfile`](Brewfile) (macOS) or a minimal apt set (Linux)
2. Checks out the submodules at their pinned commits
3. Symlinks every file in `home/` to `~/.<name>` and every entry in `home/config/` to `~/.config/<name>`. Existing files are **skipped, not replaced**, so check its output for 🚫 lines
4. Installs the pure prompt, zsh plugins, and Claude Code

## Layout

| Repo path         | Linked to         | Notes                                           |
| ----------------- | ----------------- | ----------------------------------------------- |
| `home/zshrc`      | `~/.zshrc`        | oh-my-zsh + pure prompt, mise, direnv, fnox     |
| `home/aliases`    | `~/.aliases`      | Sourced from zshrc                              |
| `home/gitconfig`  | `~/.gitconfig`    | Aliases, SSH commit signing via 1Password, `gh` credential helper |
| `home/githelpers` | `~/.githelpers`   | Used by the `git l` / `git hp` aliases          |
| `home/gitignore`  | `~/.gitignore`    | Global excludes                                 |
| `home/ssh/config` | `~/.ssh/config`   | 1Password SSH agent, GitHub over port 443       |
| `home/ssh/allowed_signers` | `~/.ssh/allowed_signers` | Lets `git log --show-signature` verify my commits |
| `home/config/nvim`| `~/.config/nvim`  | Submodule: fork of kickstart.nvim               |
| `home/oh-my-zsh`  | `~/.oh-my-zsh`    | Submodule                                       |
| `home/config/mise`| `~/.config/mise`  | node, python, ruby, java + global npm CLIs      |
| `home/default-gems` | `~/.default-gems` | Gems mise installs with every new Ruby        |

## Machine-specific config (not checked in)

This repo is public. Keep private or per-machine settings in these files, which are included automatically if they exist:

- `~/.gitconfig.local`: e.g. a work email for specific directories via `[includeIf "gitdir:~/work/"]`
- `~/.ssh/config.local`: private hosts, servers, per-host keys

## Updating

```sh
git submodule update --remote   # bump oh-my-zsh / nvim to latest, then commit the new pointers
brew bundle --file=~/dotfiles/Brewfile
```
