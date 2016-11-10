override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Ded"
  PathShort="\w";

  GIT_PROMPT_COMMAND_OK=">"
  GIT_PROMPT_COMMAND_FAIL="${Red}>(_LAST_COMMAND_STATE_)"
  GIT_PROMPT_PREFIX=""
  GIT_PROMPT_SUFFIX=""
  GIT_PROMPT_SEPARATOR=" "
  GIT_PROMPT_CLEAN=""

  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Yellow}${PathShort}${ResetColor}"
}

reload_git_prompt_colors "Ded"
