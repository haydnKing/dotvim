# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.vim/git-completion.bash ]; then
  . ~/.vim/git-completion.bash
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

export EDITOR="nvim"

#colourfull command line
export CLICOLOR=1

alias vim="nvim"

alias ghclean='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

#add texlive 2012 to the path if it's installed
TEXLIVEDIR="/usr/local/texlive/2013/bin/`uname -m`-linux"
if [ -d "$TEXLIVEDIR" ]; then
    PATH=$TEXLIVEDIR:$PATH
fi

#jhbuild
PATH=$PATH:~/.local/bin

#Synthace
export GOPATH=~/go 
export GOPRIVATE=github.com/Synthace
PATH=$PATH:~/go/bin 
PATH=$PATH:~/src/arcanist/bin/

#don't fail element tests due to open files
ulimit -S -n 2048


PATH=$PATH:/home/haydn/src/MiniZincIDE-2.5.5-bundle-linux-x86_64/bin/

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/haydn/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/haydn/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/haydn/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/haydn/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/haydn/src/google-cloud-sdk/path.bash.inc' ]; then . '/home/haydn/src/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/haydn/src/google-cloud-sdk/completion.bash.inc' ]; then . '/home/haydn/src/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
