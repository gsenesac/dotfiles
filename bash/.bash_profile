#!/bin/bash
#Load dotfiles
for file in ~/.{bash_prompt,aliases,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

shopt -s nocaseglob

PROMPT_DIRTRIM=2
