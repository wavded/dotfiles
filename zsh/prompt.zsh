autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]; then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}•'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}•'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' (%b%c%u%B%F{green})'
    } else {
        zstyle ':vcs_info:*' formats ' (%b%c%u%B%F{red}•%F{green})'
    }

    vcs_info
}

setopt prompt_subst
PROMPT='%{$fg_no_bold[green]%}%n%{$fg_no_bold[blue]%}•%{$fg_no_bold[cyan]%}%m $fg_bold[magenta]%c$fg_no_bold[green]${vcs_info_msg_0_} %{$reset_color%} '
if [[ $ZSH_VERSION > 4.3 ]]; then
   autoload -U add-zsh-hook
   add-zsh-hook precmd  theme_precmd
fi
