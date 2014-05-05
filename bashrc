# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
DEFAULT='\[\033[0m\]'

# User specific aliases and functions
PS1="$RED[\u@\h \W$YELLOW\$(parse_git_branch)$RED]\$ $DEFAULT"

export EDITOR="vim"

alias ls="ls --color=always"

#add texlive 2012 to the path if it's installed
TEXLIVEDIR="/usr/local/texlive/2013/bin/`uname -m`-linux"
if [ -d "$TEXLIVEDIR" ]; then
    PATH=$TEXLIVEDIR:$PATH
fi
