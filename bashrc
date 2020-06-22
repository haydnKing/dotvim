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

export EDITOR="nvim"

#colourfull command line
export CLICOLOR=1

alias vim="nvim"

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

# Kubernetes
KUBEPS1=""
if [ -x `which kubectl` ]; then
  KUBEPS1=' \[\033[01;38;5;214m\](k8s:$(kubectl config current-context))'

  if [ -x `which whiptail` ]; then
    # Handy function to quickly switch kubernetes context, they can be a pain otherwise...
    function kc() {
      values=$(kubectl config get-contexts -o name | sort)
      selection=$(echo $values | xargs -n 1 | awk '{print v++,$1}')
      arr=($values)
      tmpfile=$(mktemp)
      whiptail --menu "Please select a kubernetes context:" 25 75 12 $selection 2>$tmpfile
      choice=$(cat $tmpfile)
      rm -rf $tmpfile

      if [ "XXX$choice" != "XXX" ]; then
        kubectl config use-context ${arr[choice]}
      fi
    }
  fi

  alias ks='kubectl config current-context'
fi

#antha compile
alias ac='antha compile $GOPATH/src/repos.antha.com/antha-ninja/elements-westeros --outdir vendor/repos.antha.com/elements --outputPackage repos.antha.com/elements'
#antha run
PipetMax() {
    antha run --driver go://github.com/Synthace/instruction-plugins/PipetMax "$@"
}
Hamilton() {
    antha run --driver go://github.com/Synthace/instruction-plugins/Hamilton "$@"
}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hjk/Workspace/google-cloud-sdk/path.bash.inc' ]; then source '/Users/hjk/Workspace/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hjk/Workspace/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/hjk/Workspace/google-cloud-sdk/completion.bash.inc'; fi

# apparently install software on mac involves editing bashrc

PATH=/Applications/MiniZincIDE.app/Contents/Resources:$PATH

export MINIZINC_PATH=/Applications/MiniZincIDE.app/Contents/Resources/minizinc
