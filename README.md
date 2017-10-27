# dotfiles

100% opinionated .dotfiles #ymmv

Includes files for zsh, vim, git, tmux, …


## Setup

```shell
$ cd $HOME
$ git clone https://github.com/philippbosch/dotfiles.git
$ dotfiles/setup.sh
```


## Adding an existing file to the repo

```shell
$ cd $HOME/dotfiles
$ mv ~/.thefilerc .
$ git add .thefilerc
$ cd $HOME
$ dotfiles/setup.sh
```

