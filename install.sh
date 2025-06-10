#!/bin/bash

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