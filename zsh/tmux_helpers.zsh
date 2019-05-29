# Useful Nerd Font icons
declare -A NERD_FONT_ICONS
NERD_FONT_ICONS[rails]=''
NERD_FONT_ICONS[redis]=''
NERD_FONT_ICONS[terminal]=''
NERD_FONT_ICONS[vim]=''

function tmux_rename_window_rails() {
  tmux_rename_window_with_icon $NERD_FONT_ICONS[rails] $1
}

function tmux_rename_window_redis() {
  tmux_rename_window_with_icon $NERD_FONT_ICONS[redis] $1
}

function tmux_rename_window_terminal() {
  tmux_rename_window_with_icon $NERD_FONT_ICONS[terminal] $1
}

function tmux_rename_window_with_icon() {
  local name="$1"
  if [ ! -z "$2" ]; then
    local name="$name $2"
  fi

  tmux rename-window "$name"
}
