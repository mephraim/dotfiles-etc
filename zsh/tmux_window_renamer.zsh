# This is a collection of methods that can be used to rename tmux windows based
# on the type of command being run.
#
# Icons that can be used when renaming windows
declare -A WINDOW_NAME_ICONS
WINDOW_NAME_ICONS[deploy]=''
WINDOW_NAME_ICONS[diff]=''
WINDOW_NAME_ICONS[git]=''
WINDOW_NAME_ICONS[git_commit]=' '
WINDOW_NAME_ICONS[git_diff]=' '
WINDOW_NAME_ICONS[git_log]=' '
WINDOW_NAME_ICONS[git_pull]='↓'
WINDOW_NAME_ICONS[git_push]='↑'
WINDOW_NAME_ICONS[javascript]=''
WINDOW_NAME_ICONS[man]=''
WINDOW_NAME_ICONS[npm]=''
WINDOW_NAME_ICONS[rails]=''
WINDOW_NAME_ICONS[redis]=''
WINDOW_NAME_ICONS[ruby]=''
WINDOW_NAME_ICONS[ssh]=''
WINDOW_NAME_ICONS[terminal]=''
WINDOW_NAME_ICONS[text]=''
WINDOW_NAME_ICONS[vim]=''

# Rename the tmux window with a nerdfont icon and an optional string.
function tmux_window_renamer::rename_window_with_icon() {
  local icon="$WINDOW_NAME_ICONS[$1]"
  local name="$icon"
  if [ ! -z "$2" ]; then
    local name="$name $2"
  fi

  # Rename the tmux window and make sure to target the same pane that the
  # process is running in. This will prevent other windows from getting renamed
  # when the current process is not in focus.
  tmux rename-window -t${TMUX_PANE} "$name"
}

# Rename the current tmux window based on the name of the command and the
# arguments passed to it.
function tmux_window_renamer::rename_based_on_command() {
  case "$1" in
    *bat*|*less*|*more*) tmux_window_renamer::rename_window_with_icon 'text';;
    *cap*deploy*) tmux_window_renamer::rename_window_with_icon 'deploy';;
    git*commit*) tmux_window_renamer::rename_window_with_icon 'git_commit';;
    git*diff*) tmux_window_renamer::rename_window_with_icon 'git_diff';;
    git*log*) tmux_window_renamer::rename_window_with_icon 'git_log';;
    git*pull*) tmux_window_renamer::rename_window_with_icon 'git_pull';;
    git*push*) tmux_window_renamer::rename_window_with_icon 'git_push';;
    git*) tmux_window_renamer::rename_window_with_icon 'git';;
    *rails*) tmux_window_renamer::rename_window_with_icon 'rails';;
    man*) tmux_window_renamer::rename_window_with_icon 'man';;
    "be "*|"bundle exec"*|irb) tmux_window_renamer::rename_window_with_icon 'ruby';;
    redis-server*) tmux_window_renamer::rename_window_with_icon 'redis';;
    "npm install"*|"yarn"|"yarn add"*) tmux_window_renamer::rename_window_with_icon 'npm';;
    "npm "*|node*|"yarn "*) tmux_window_renamer::rename_window_with_icon 'javascript';;
    ssh*) tmux_window_renamer::rename_window_with_icon 'ssh';;
    vim*|nvim*) tmux_window_renamer::rename_window_with_icon 'vim';;
  esac
}

# Add a function for renaming window after the command executes.
function rename_window_precmd() {
  tmux_window_renamer::rename_window_with_icon 'terminal'
}
precmd_functions=($precmd_functions rename_window_precmd)
