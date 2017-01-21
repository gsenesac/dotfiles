#!/bin/bash

#vimrc file requires these directoriesj
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

    for dir in $(ls -d */);
    do
        #Stow complains about already existant dotfiles, so
        #we'll rename them to end with .bak 
        for file in $(find $dir -type f -printf '%f\n');
        do 
            if [ -e ~/$file ] && [ ! -h ~/$file ];
            then
              echo "$file is present at ~"
              echo "mv'ing the file to .bak"
              mv ~/$file ~/$file.bak
            fi
        done
        
        stow $dir
    done

fi;

echo "Now source ~/.bashrc"
