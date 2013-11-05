dotfiles
========

This is a set of basic files I keep in my home dir on all the servers 
I work with. The technique for managing them is the one described by
Ryan Tomayko [here](https://github.com/rtomayko/dotfiles#readme).

Usage
-----

    cd $HOME
    chsh -s /bin/zsh
    git init
    echo "*" >> .git/info/exclude
    git remote add origin git://github.com/philippbosch/dotfiles.git
    git pull origin master
    git submodule init
    git submodule update

Logout. Login. Finished.
