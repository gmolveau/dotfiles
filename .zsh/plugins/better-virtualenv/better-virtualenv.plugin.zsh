# from https://github.com/mitsuhiko/dotfiles/blob/3c4b18c2190d94655ea64df7bc1d3d45b6abba6e/zsh/custom/plugins/better-virtualenv/better-virtualenv.plugin.zsh
function virtualenv_prompt_info() {
  [[ -n ${VIRTUAL_ENV} ]] || return
  local NAME="${VIRTUAL_ENV:t}"
  if [[ $NAME == "venv" || $NAME == "env" || $NAME == ".venv" ]]; then
    local BASE="${VIRTUAL_ENV:h}"
    NAME="${BASE:t}"
  fi
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${NAME}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1
