#!/usr/bin/env bash
echo "loading .bash_aliases"
# TODO directory history?
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
alias he="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME status" # same idea as 'te'
alias hf="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME diff"
alias homegraph="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME log --all --decorate --oneline --graph"
alias homels="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME ls-tree --name-only master"
alias homeunstage="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME restore --staged"
alias homeuntrack="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME rm -r --cached"
alias homeamend="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME commit --amend"
alias hadd="/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME add"
# pure git #
alias ginit='git init'
alias gadd='git add'
alias te="git status"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gpush="git push"
alias gpull="git pull"
alias grv="git remote -v"
alias graph="git log --all --decorate --oneline --graph"
alias gch="git checkout"
alias gchm="git checkout master"
alias gth="git ls-tree -r --name-only HEAD"
alias gtm="git ls-tree -r --name-only master"
alias gf="git diff"
alias unstage="git restore --staged" # remove file from staging area, '-r' flag for directories
alias untrack="git rm -r --cached" # untrack files currently tracked by git, '-r' flag for directories
alias amend="git commit --amend"
alias restore="git restore"
# shell interaction
alias c='clear'
alias cnd='clear &&' 
alias p="pwd"
alias pp="clear && pwd"
#alias ls="ls -G" #darwin os only
alias lah="ls -lah"
alias las="du -sh * | sort -h" # sort by size
alias pa="clear && pwd && echo '-----' && ls"
alias paa="clear && pwd && echo '-----' && ls -a"
alias lagrep='ls -a | grep' # append your simple grep search
# inbox
alias i="/usr/bin/vi ~/org/inbox.org"
alias ii="inbox fetch --clean >> *inbox.org"
alias cati="cat ~/org/inbox.org" 
# quick navigation
alias gg="cd && org && org"
alias uni="~/org/uni"
alias bin="~/bin"
alias drive="~/myDrive"
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
alias tmupdate="git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm" # install packages on fresh OS
#alias tpls="ls ~/.tmuxp/"
## misc aliases
alias hh="echo 'https://github.com/Ma-Nu-El'"
alias match="matchfilename"
alias x="command -v" 
alias X="command -V"
alias R="ranger"
alias V="sxiv -to"
alias ptt="tree | less"
alias O="xdg-open &>/dev/null"
alias openwith="mimeopen -a"
alias chmodx="chmod +x"
alias now="date && cal"
alias de="deploy encrypt"
alias dd="deploy decrypt"
alias fire="firefox --private-window >/dev/null 2>/dev/null &"
alias rr="rm -rf ~/org/auxRoam && roam dummy"
alias thea="cd ~ && clear && pwd && he"
alias the="cd-and-git-status"
echo "loaded aliases"
### FUNCTIONS ###
echo "loading functions"
# git clone from @Ma-Nu-El in github.
manuclone(){
	if [[ -z "$1"  ]]
	then
		echo "example: 'manuclone foo bar' is the same as"
		echo "'git clone git@github.com:Ma-Nu-El/foo bar'"
	else
	git clone git@github.com:Ma-Nu-El/$1 
	fi	
}
echo "loaded functions"

# quick roam 
r(){
pushd .
~/org/auxRoam
}

#quick useful defaults

# smarter org
# https://unix.stackexchange.com/questions/6435/how-to-check-if-pwd-is-a-subdirectory-of-a-given-path
org(){
if [[ "$PWD" = "$HOME/org" ]]
then
cd org
else
cd ~/org
fi
}

# smarter norg
norg(){
if [[ "$PWD" = "$HOME/norg" ]]
then
	cd norg
else
cd ~/norg
fi
}

# cd and git status into directory
cd-and-git-status(){
if [ -d "$1" ] # if argument is a directory
then
	cd $1
	clear && pwd && git status
else
	if [ -z $1 ]
	then
		clear && pwd && git status
	fi
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
