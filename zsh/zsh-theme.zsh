autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%K{green} '
zstyle ':vcs_info:*' unstagedstr '%K{yellow} '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{white}:%r'
zstyle ':vcs_info:*' enable git svn

theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%K{cyan}%F{black} ⭠ %b %{%k%} %c%u%B%{%k%}'
    } else {
        zstyle ':vcs_info:*' formats '%K{cyan}%F{black} ⭠ %b %{%k%} %c%u%B%K{red} %{%k%}'
    }

    vcs_info
}

prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo "%K{magenta}%F{black} $user@%m %{%f%b%k%}"
  fi
}

PROMPT='%{%f%b%k%}$(prompt_context)%3~ ${vcs_info_msg_0_}%{%f%b%k%}› '
# RPROMPT='[%*]'

if [[ $ZSH_VERSION > 4.3 ]]; then
   autoload -U add-zsh-hook
   add-zsh-hook precmd  theme_precmd
fi
