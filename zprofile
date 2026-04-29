
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats " %F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats " %F{cyan}%c%u(%b)%f %a"
zstyle ':vcs_info:*' stagedstr "%F{green}"
zstyle ':vcs_info:*' unstagedstr "%F{red}"
zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if git --no-optional-locks status --porcelain 2> /dev/null | grep -q "^??"; then
    hook_com[staged]+="%F{red}"
  fi
}

setopt PROMPT_SUBST
export PROMPT='%F{red}%n%f:%1~$vcs_info_msg_0_ %# '


# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$PATH:/Users/haydnking/go/bin:/Applications/MiniZincIDE.app/Contents/Resources
export GOPRIVATE=github.com/Synthace

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
