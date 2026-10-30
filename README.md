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
3. Symlinks everything in `home/` into `~` with [GNU Stow](https://www.gnu.org/software/stow/). Stow never overwrites existing files; on conflicts it stops and lists them
4. Installs the pure prompt, zsh plugins, and Claude Code

## Layout

`home/` mirrors `~`: `home/.zshrc` is linked as `~/.zshrc`, `home/.config/mise/config.toml` as `~/.config/mise/config.toml`, and so on. To add a file, move it into the same place under `home/` and run `stow -d ~/dotfiles -t ~ --restow home`.

| Path in `home/`             | Notes                                                     |
| --------------------------- | --------------------------------------------------------- |
| `.zshrc`                    | oh-my-zsh + pure prompt, mise, direnv, fnox               |
| `.aliases`                  | Sourced from `.zshrc`                                     |
| `.gitconfig`                | Aliases, SSH commit signing via 1Password, `gh` credentials |
| `.githelpers`               | Used by the `git l` / `git hp` aliases                    |
| `.gitignore`                | Global excludes                                           |
| `.ssh/config`               | 1Password SSH agent, GitHub over port 443                 |
| `.ssh/allowed_signers`      | Lets `git log --show-signature` verify my commits         |
| `.config/mise/config.toml`  | node, python, ruby, java + global npm CLIs                |
| `.default-gems`             | Gems mise installs with every new Ruby                    |
| `.config/nvim`              | Submodule: fork of kickstart.nvim                         |
| `.oh-my-zsh`                | Submodule                                                 |
| `.stow-local-ignore`        | Files stow should not link                                |

## Machine-specific config (not checked in)

This repo is public. Keep private or per-machine settings in these files, which are included automatically if they exist:

- `~/.gitconfig.local`: e.g. a work email for specific directories via `[includeIf "gitdir:~/work/"]`
- `~/.ssh/config.local`: private hosts, servers, per-host keys

## Updating

```sh
git submodule update --remote   # bump oh-my-zsh / nvim to latest, then commit the new pointers
brew bundle --file=~/dotfiles/Brewfile
```
