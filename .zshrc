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
if [[ -f /usr/share/zsh-antigen/antigen.zsh ]] ; then
  source /usr/share/zsh-antigen/antigen.zsh
  antigen bundle lukechilds/zsh-nvm
fi


# ZSH syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# ZSH completions
fpath=(/usr/local/share/zsh-completions $fpath)


# AWS autocompletion
source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh


# Aliases
source $HOME/.aliases


# Editor
export EDITOR=$(which vim)


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/pb/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/pb/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/pb/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/pb/.nvm/versions/node/v8.4.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
export NVM_DIR="$HOME/.nvm"
source /usr/local/opt/nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$PATH:/usr/local/opt/python@2/libexec/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

