
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/haydnking/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/haydnking/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/haydnking/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/haydnking/google-cloud-sdk/completion.zsh.inc'; fi

autoload -Uz vcs_info

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %m%u%c %F{reset}"
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

precmd() {
    vcs_info
    print -P '%B%~%b ${vcs_info_msg_0_}'
}

PROMPT='%B%(!.#.$)%b '
