#!/bin/bash

# Add oh-my-zsh as a submodule
if [ ! -d home/oh-my-zsh ]
then
    git submodule add https://github.com/ohmyzsh/ohmyzsh.git home/oh-my-zsh
fi

# Update oh-my-zsh
git submodule update --init --recursive --remote

# Backup existing zshrc
if [ -f "$HOME/.zshrc" ]
then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Link all files in home to the home directory
for file in $(ls home)
do
    if [[ -f "$HOME/.$file" ]]
    then
        echo "🚫 .$file exists. Skipping."
    else
        echo "🔗 Linking .$file"
        ln -s "$(pwd)/home/$file" "$HOME/.$file"
    fi
done