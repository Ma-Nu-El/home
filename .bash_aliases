#!/usr/share/env bash
# TODO directory history?
echo "loading .bash_aliases"
### promt ###
export PS1='\
\[\033[1;37m\]\
\[\033[1;33m\]\
\$ \
\[\033[0m\]\
'
### shopt ###
shopt -s autocd
shopt -s cdspell
### environment variables ###
#export ORGDIR=~ USE EVAL maybe?
### vi ###
git config --global core.editor "vi"
export VISUAL=vi
export EDITOR="$VISUAL"
echo "enabled Bash built-ins"
### ALIASES ###
### git ###
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
### home bare repo ###
alias home="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME"
alias homest="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME status"
alias homegraph="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME log --all --decorate --oneline --graph"
alias homels="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME ls-tree --name-only master"
alias ginit='git init'
alias gadd='git add'
alias gst="git status"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gpsh="git push"
alias gpll="git pull"
alias grv="git remote -v"
alias graph="git log --all --decorate --oneline --graph"
alias giff="git diff"
alias gch="git checkout"
alias gchm="git checkout master"
alias gth="git ls-tree -r --name-only HEAD"
alias gtm="git ls-tree -r --name-only master"
# shell interaction
alias c='clear'
alias cnd='clear &&' 
alias p="pwd"
alias pp="clear && pwd"
alias a="ls"
alias aa="ls -a"
alias lah="ls -lah"
alias pa="clear && pwd && echo '-----' && ls"
alias paa="clear && pwd && echo '-----' && ls -a"
alias lagrep='ls -a | grep' # append your simple grep search
# quick navigation
alias u="~/org/uni"
alias b="~/bin"
alias i="/usr/bin/vi ~/org/inbox.org"
alias D="~/Desktop"
alias DD="~/Downloads"
alias E="exit"
alias h="~"
alias h1="~/Desktop"
alias h2="~/Downloads"
alias h3="~/Documents"
alias h4="~/Pictures"
alias h5="~/Videos"
# quick editor
alias v="vim"
alias e='emacs -nw' # opens new instance of emacs in the terminal: no GUI
alias ed="emacs --daemon" # creates default emacs server named 'server'
alias ec='emacsclient -t' # attach to the default emacs server
alias edn="emacs-daemon-new" # append your emacs daemon name
alias els="ls -1 /tmp/emacs${UID}" # get list of running emacs servers
alias ecs='emacsclient -t -s' # append your server name to be attached to
# tmux
alias t="tmux" 
alias tn="tmux new-session" # create session with default name
alias tns="tmux new -s" # append your session name to be created
alias tks="tmux kill-session -t" # append your session name to be killed
alias tls="tmux ls" # list sessions # <prefix> s
alias ta="tmux attach-session" # attach to last session
alias tas="tmux attach-session -t" # append your session name to be attached to
#alias tpls="ls ~/.tmuxp/"
## misc aliases
alias match="findmatch"
alias X="command -v"
alias R="ranger"
alias ptt="tree | less"
alias open="xdg-open &>/dev/null"
alias openwith="mimeopen -a"
alias chmodx="chmod +x"
alias now="date && cal"
alias de="deploy encrypt"
alias dd="deploy decrypt"
alias fire="firefox --private-window >/dev/null 2>/dev/null &"
echo "loaded aliases"
### FUNCTIONS ###
echo "loading functions"
# git clone from @Ma-Nu-El in github.
manuclone(){
	if [[ -z "$1"  ]]
	then
		echo "example: 'manuclone foo bar' is the same as"
		echo "'git clone git@github..Nu-El/foo bar'"
	else
	git clone git@github.com:Ma-Nu-El/$1 
	fi	
}
echo "loaded functions"

# quick roam 
r(){
pushd .
cd ~/org/auxRoam
}

#quick useful defaults

# smarter org
# https://unix.stackexchange.com/questions/6435/how-to-check-if-pwd-is-a-subdirectory-of-a-given-path
o(){
if [[ "$PWD" = "$HOME/org" ]]
then
cd org
else
cd ~/org
fi
}

# smarter norg
n(){

if [[ "$PWD" = "$HOME/norg" ]]
then
cd norg
else
cd ~/norg
fi

}

### MISC
# add ~/.emacs.d/bin to $PATH
#https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#the-bindoom-utility
export PATH=~/.emacs.d/bin:$PATH 
# how to verify existence first?

#https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
#if [ -z "${PATH-}" ]; then export PATH=/usr/local/bin:/usr/bin:/bin; fi
echo "loaded .bash_aliases"

