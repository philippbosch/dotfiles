dotfiles
========

This is a set of basic files I keep in my home dir on all the servers 
I work with. The technique for managing them is the one described by
Ryan Tomayko [here](https://github.com/rtomayko/dotfiles#readme).

Prerequisites
-------------

### Linux

    apt-get install -y zsh git python-pip
    pip install autoenv


### OSX

    brew install zsh git python
    pip install autoenv


Installation
------------

### Linux

    cd $HOME
    chsh -s /bin/zsh
    git init
    echo "*" >> .git/info/exclude
    git remote add origin https://github.com/philippbosch/dotfiles.git
    git pull origin master
    git submodule init
    git submodule update
    ln -s $HOME/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup

### OSX

    sudo -s 
    echo /usr/local/bin/zsh >> /etc/shells
    exit
    cd $HOME
    chsh -s /usr/local/bin/zsh
    git init
    echo "*" >> .git/info/exclude
    git remote add origin https://github.com/philippbosch/dotfiles.git
    git pull origin master
    git submodule init
    git submodule update
    ln -s $HOME/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
