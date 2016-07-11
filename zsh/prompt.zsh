# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

autoload -Uz vcs_info
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' stagedstr '%F{green}◀'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}◀'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{white}:%r'
zstyle ':vcs_info:*' check-for-changes true

set-prompt() {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%F{green}%b%{%k%}%c%u%B%{%k%} '
    } else {
        zstyle ':vcs_info:*' formats '%F{green}%b%{%k%}%c%u%B%F{red}◁%{%k%} '
    }
    vcs_info
}

set-prompt-context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo "%K{magenta}%F{black} $user@%m %{%f%b%k%}"
  fi
}

PROMPT='%{%f%b%k%}$(set-prompt-context)%3~ ${vcs_info_msg_0_}%{%f%b%k%}› '
# RPROMPT='[%*]'

autoload -U add-zsh-hook
add-zsh-hook precmd set-prompt
