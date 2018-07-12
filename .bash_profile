# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you donÃ¢ÂÂt want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

#allow to cd to bash variables
shopt -s cdable_vars
#set vi mode 
set -o vi

#set up for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:/Applications/DevDesktop/tools"
