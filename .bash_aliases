#!/usr/share/env bash
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
#alias gitt='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
alias ginit='git init'
alias gadd='git add'
alias gst="git status"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gpsh="git push"
alias gpll="git pull"
alias gsm="git submodule"
alias gsmfr="git submodule foreach --recursive"
alias grv="git remote -v"
alias graph="git log --all --decorate --oneline --graph"
alias giff="git diff"
alias gt="git ls-tree -r --name-only"
alias gth="git ls-tree -r --name-only HEAD"
alias gtm="git ls-tree -r --name-only master"
alias ct="config ls-tree -r --name-only"
alias cth="config ls-tree -r --name-only HEAD"
alias ctm="config ls-tree -r --name-only master"
alias gch="git checkout"
alias gchm="git checkout master"
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
alias pt="clear && pwd && echo '-----' && tree ./"
alias pt1="clear && pwd && echo '-----' && tree -L 1./"
alias pt2="clear && pwd && echo '-----' && tree -L 2./"
alias pt3="clear && pwd && echo '-----' && tree -L 3./"
alias pt4="clear && pwd && echo '-----' && tree -L 4./"
alias 0="clear && pwd && echo '-----' && tree ./ | less"
alias 1="clear && pwd && echo '-----' && tree -L 1./ | less"
alias 2="clear && pwd && echo '-----' && tree -L 2./ | less"
alias 3="clear && pwd && echo '-----' && tree -L 3./ | less"
alias 4="clear && pwd && echo '-----' && tree -L 4./ | less"
alias 5="clear && pwd && echo '-----' && tree -L 5./ | less"
alias 6="clear && pwd && echo '-----' && tree -L 6./ | less"
alias 7="clear && pwd && echo '-----' && tree -L 7./ | less"
alias lagrep='ls -a | grep' # append your simple grep search
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias h="cd ~"
alias o="cd ~/org"
alias n="cd ~/norg"
alias i="/usr/bin/vi ~/org/inbox.org"
alias d="cd ~/Desktop"
alias E="exit"
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
alias fire="firefox --private-window >/dev/null 2>/dev/null &"
## misc aliases
alias chmodx="chmod +x"
alias now="date && cal"
echo "loaded aliases"
### FUNCTIONS ###
echo "loading functions"
# dotfiles edition
cdf(){
	if [[ -z "$1"  ]]
	then
		echo "vim to dotfile of...?"
		echo "b = bash"
		echo "v = vim"
		echo "t = tmux"
		echo "e = doom emacs"
		echo "example: 'cdf v' is the same as"
		echo "'vim $HOME/.vimrc'"
	fi	
	if [[ "$1" == "b" ]] 
	then
		vim $HOME/.bash_aliases
	fi
	if [[ "$1" == "t" ]]
	then
		vim $HOME/.tmux.conf
	fi
	if [[ "$1" == "v" ]]
	then
		vim $HOME/.vimrc
	fi
	if [[ "$1" == "e" ]]
	then
		vim $HOME/.doom.d/config.el
	fi
}
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

### MISC
# add ~/.emacs.d/bin to $PATH
#https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#the-bindoom-utility
export PATH=~/.emacs.d/bin:$PATH 
# how to verify existence first?

#https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
#if [ -z "${PATH-}" ]; then export PATH=/usr/local/bin:/usr/bin:/bin; fi
echo "loaded .bash_aliases"

