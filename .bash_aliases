#!/usr/bin/env bash
# TODO directory history?
# environment variables
. ~/.bash/env
# prompt
. ~/.bash/prompt
### shopt ###
. ~/.bash/shopt
### aliases ###
. ~/.bash/aliases
### functions ###
. ~/.bash/functions
### MISC
### vi ###
git config --global core.editor "vi"
export VISUAL=vi
export EDITOR="$VISUAL"
### doom emacs ###
# add ~/.emacs.d/bin to $PATH
#https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#the-bindoom-utility
export PATH=~/.emacs.d/bin:$PATH 
# how to verify existence first?

#https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
#if [ -z "${PATH-}" ]; then export PATH=/usr/local/bin:/usr/bin:/bin; fi
