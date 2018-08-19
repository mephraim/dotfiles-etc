#!/bin/sh

source ./installers/set_dotfiles_location.sh

installer() {
  if [ $# -eq 0 ]; then
    echo "Specify an installer to run"
    exit 0
  fi

  local script_name="./installers/install-$1.sh"
  if [ ! -f "$script_name" ]; then
    echo "Installer not found!"
    exit 0
  fi

  source "$script_name"
}

installer $1
