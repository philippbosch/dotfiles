#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Antigen
source /usr/share/zsh-antigen/antigen.zsh
antigen bundle lukechilds/zsh-nvm


# AWS autocompletion
source $(which aws_zsh_completer.sh)


# Aliases
source $HOME/.aliases
