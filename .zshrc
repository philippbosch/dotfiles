# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git django gem git-flow github heroku node npm pip redis-cli ruby terminitor bower brew cloudapp coffee docker fabric osx pod supervisor grunt)

source $ZSH/oh-my-zsh.sh

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Customize to your needs...
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH"

# Pure prompt
autoload -U promptinit && promptinit
prompt pure

# Misc
export PIP_LOG_FILE="/tmp/pip-log.txt"

# Editor
if [[ ! -z "`command -v subl`" ]] ; then
    export EDITOR="`which subl` -w"
elif [[ ! -z "`command -v choc_wait`" ]] ; then
    export EDITOR="`which choc_wait`"
elif [[ ! -z "`command -v mate_wait`" ]] ; then
    export EDITOR="`which mate_wait`"
elif [[ ! -z "`command -v joe`" ]] ; then
    export EDITOR="`which joe`"
elif [[ ! -z "`command -v nano`" ]] ; then
    export EDITOR="`which nano`"
fi

export LESSEDIT="$EDITOR %f"

# Aliases
if [ -e .aliases ] ; then
    source .aliases
fi

# OSX-specific aliases
if [ ! "$SSH_TTY" ] && [[ "$OSTYPE" =~ "darwin" ]] ; then
    alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
    alias flush="dscacheutil -flushcache"
    alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
    alias imageoptim="open -a /Applications/ImageOptim.app"
fi

# virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Put customizations into .zshrc.local. They will be included here if the file exists.
if [[ -e .zshrc.local ]] ; then
    source .zshrc.local
fi

# autoenv (https://github.com/kennethreitz/autoenv)
if [[ -e /usr/local/bin/activate.sh ]] ; then
    source /usr/local/bin/activate.sh
else
    if [[ -e /usr/local/opt/autoenv/activate.sh ]] ; then
        source /usr/local/opt/autoenv/activate.sh
    fi
fi

function use_venv() {
    # if [[ -z "$VIRTUAL_ENV" ]] ; then
        if [[ -f ./.virtualenvname ]] ; then
            VENV_DIR="$HOME/Dev/VirtualEnvs/`cat .virtualenvname`"
        elif [[ -e ./venv/bin/activate ]] ; then
            VENV_DIR="./venv"
        elif [[ -e $HOME/Dev/VirtualEnvs/`basename \`pwd\``/bin/activate ]] ; then
            VENV_DIR="$HOME/Dev/VirtualEnvs/`basename \`pwd\``"
        else
            echo "Unable to find a virtualenv directory." 1>&2
            return 99
        fi
        echo "Activating virtualenv in $VENV_DIR"
        source $VENV_DIR/bin/activate
    # fi
}
alias ve=use_venv

# (must come after oh-my-zsh because it overwrites the cd() defined there)
function cd() {
    emulate -LR zsh
    if builtin cd "$@"
    then
        l
        autoenv_init
        return 0
    else
        return $?
    fi
}
