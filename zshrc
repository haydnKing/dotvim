
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/haydnking/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/haydnking/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/haydnking/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/haydnking/google-cloud-sdk/completion.zsh.inc'; fi

autoload -Uz vcs_info

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c "
zstyle ':vcs_info:*' actionformats ' %F{blue}%b%f|%F{yellow}%a %m%u%c %F{reset}'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}✚%F{reset}'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%F{reset}'

### Display the existence of files not yet known to VCS

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+=' %F{yellow}T%f'
    fi
}

setopt prompt_subst

precmd() {
    vcs_info
    print -P '%B%~%b \${vcs_info_msg_0_}'
}

PROMPT='%B%(!.#.$)%b '

alias vim="nvim"

PATH=$PATH:~/.local/bin

#Synthace
export GOPATH=~/go
export GOPRIVATE=github.com/Synthace
PATH=$PATH:/usr/local/go/bin:~/go/bin
PATH=$PATH:~/src/arcanist/bin/
export MINIZINC_PATH=/opt/minizinc/binminizinc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# node version 22
nvm use 22 --silent

# delete squash-merged branches
alias rmsquashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands
