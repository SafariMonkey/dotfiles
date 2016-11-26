
#! /bin/bash

if [ -x /usr/bin/dircolors ]; then
	if [[ "$TERM" =~ 256 ]]; then
		dircolfile=$HOME/dotfiles/dircolors/256
	else
		dircolfile=$HOME/dotfiles/dircolors/16
	fi
	test -r $dircolfile && eval "$(dircolors -b $dircolfile)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

alias lh='ls -sh'
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# One command for creating and changing directories
mcd() { mkdir $1; cd $1; }
smcd() { sudo mkdir $1; cd $1; }

# Short forms of commands
alias sr='screen -r'
alias sdr='screen -dr'
alias c=clear

alias nano='nano -wxOST 4'

alias sprunge='curl -F "sprunge=<-" http://sprunge.us'

alias mosh='mosh --predict=experimental'

# scp appears to bypass ~/bin/ssh -> ~/bin/ssh-ident, force it not to
alias scp='scp -S ssh-ident'

# docker
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drm='docker rm -fv $(docker ps -qa)'
alias dvrm='docker volume rm $(docker volume ls -q)'

# git
alias gc='git commit'
alias gca='git commit --amend'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch --all'
alias gp='git push'
alias gpp='git pull'
alias gs='git status'
alias ggrep='git grep -B0 -A0'
alias ggrepi='git grep -i -B0 -A0'
alias gu='git stash && git pull && git stash pop'

# tmux
alias tmux='tmux -2'
txr() { fst=${1:-}; shift; tmux a -t "$fst" "$@"; } # screen -x
tdr() { fst=${1:-}; shift; tmux a -dt "$fst" "$@"; } # screen -dr
alias tn='tmux new -s' # screen -mS
alias tls='tmux ls 2>/dev/null || echo "No tmux sessions running"'

setupterm() { infocmp $TERM | ssh $1 tic -; }