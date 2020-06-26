#!/usr/share/env bash
echo "loading .bash_aliases"
export PS1='\
\[\033[1;37m\]\
\[\033[1;33m\]\
\$ \
\[\033[0m\]\
'
shopt -s autocd
# vi
git config --global core.editor "vi"
export VISUAL=vi
export EDITOR="$VISUAL"
echo "enabled Bash built-ins"
# git
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
## home bare repo
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
alias pa="clear && pwd && echo '-----' && ls"
alias paa="clear && pwd && echo '-----' && ls -a"
alias pt="clear && pwd && echo '-----' && tree ./"
alias ptp='watch -n1 -t "clear && tree ./"'
alias ct="clear && tree ./"
alias lgrep='ls | grep' # append your simple grep search
alias lagrep='ls -a | grep' # append your simple grep search
alias ..="cd .."
alias ..p="cd ../ && pwd"
alias ..pa="cd ../ && clear && pwd && echo '-----' && ls"
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias h="cd ~"
alias E="exit"
# quick editor
alias v="vim"
alias ed="emacs --daemon" # creates default emacs server named 'server'
alias edn="emacs-daemon-new" # append your emacs daemon name
alias els="ls -1 /tmp/emacs${UID}"
alias ec='emacsclient -t' # attach to the default emacs server
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
alias temp='systemp'
echo "loaded aliases"
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
# git clone from @Ma-Nu-El (github)
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
echo "loaded .bash_aliases"
