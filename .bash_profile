#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  # bash completion
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi

#set vi mode 
set -o vi
#allow to cd to bash variables
shopt -s cdable_vars

#set up for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Load the shell dotfiles, and then some:
for file in ~/.config/bash/bash_{path,prompt,exports,aliases,extra,private}; do
  [ -r "$file" ] && source "$file"
done
unset file
