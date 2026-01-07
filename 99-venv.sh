# Then Define separate functions
function chpwd_auto_venv() {
  # If already in a virtualenv, do nothing
  if [[ -n "$VIRTUAL_ENV" && "$PWD" != *"${VIRTUAL_ENV:h}"* ]]; then
    deactivate
    return  
  fi

  [[ -n "$VIRTUAL_ENV" ]] && return

  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      return
    fi
    dir="${dir:h}"
  done
}

chpwd_functions+=(chpwd_auto_venv)
