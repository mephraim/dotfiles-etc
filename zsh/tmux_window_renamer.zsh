# Tmux Window Renamer
#
# This set of functions will automatically rename the current tmux window based
# on the command currently being run in the window.
#
# The automatic renaming functionality will be disabled if the user manually
# renames a window.
#
# Nerd Font Icons that will be used when renaming windows
declare -A TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[deploy]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[diff]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[docker]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git_commit]=' '
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git_diff]=' '
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git_log]=' '
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git_pull]='↓'
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[git_push]='↑'
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[javascript]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[man]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[npm]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[rails]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[redis]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[ruby]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[ssh]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[terminal]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[text]=''
TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[vim]=''

# Initialize the tmux window renamer
function tmux_window_renamer::init() {
  tmux_window_renamer::bind_custom_rename

  # Register a custom precmd, while keeping any existing precmds
  precmd_functions=($precmd_functions tmux_window_renamer::rename_window_precmd)
}

# Bind the window rename key to a custom command that stores a variable
# indicating that window has been renamed so the automatic renamer doesn't
# rename it.
function tmux_window_renamer::bind_custom_rename() {
  local lock_window_env_name="LOCK_WINDOW_NAME_$(tmux display-message -p '#I')"

  # Clear the window lock variable if it already exists
  tmux set-environment -u $lock_window_env_name

  # Unbind the default rename key because we'll be replacing it with a custom one
  tmux unbind -T prefix ","

  # Whenever the user renames a window, store a session local env variable for the window indicating the name is locked
  tmux bind-key -T prefix "," command-prompt -I "#W" "rename-window -- '%%'; set-environment $lock_window_env_name yes"
}

# Is the current pane the first pane in the window?
function tmux_window_renamer::is_first_pane() {
  local pane_number="$(tmux display -pt "${TMUX_PANE:?}" '#{pane_index}')"
  [ $pane_number -eq 0 ]
}

# Was the name of this window locked by the user changing the window name manually?
function tmux_window_renamer::is_window_name_locked() {
  [ $(tmux show-environment | grep -c LOCK_WINDOW_NAME_$(tmux display-message -p '#I')) -eq 1 ]
}

# Rename the tmux window with a nerdfont icon and an optional string.
function tmux_window_renamer::rename_window_with_icon() {
  local icon="$TMUX_WINDOW_RENAMER_WINDOW_NAME_ICONS[$1]"
  local name="$icon"
  if [ ! -z "$2" ]; then
    local name="$name $2"
  fi

  # Rename the tmux window and make sure to target the same pane that the
  # process is running in. This will prevent other windows from getting renamed
  # when the current process is not in focus.
  tmux rename-window -t${TMUX_PANE} "$name"
}

# Automatically rename the window if the window name hasn't been changed manually
function tmux_window_renamer::rename() {
  if tmux_window_renamer::should_auto_rename; then
    tmux_window_renamer::rename_based_on_command $1
  fi
}

# Rename the current tmux window based on the name of the command and the
# arguments passed to it.
function tmux_window_renamer::rename_based_on_command() {
  case "$1" in
    *bat*|*less*|*more*) tmux_window_renamer::rename_window_with_icon 'text';;
    *cap*deploy*) tmux_window_renamer::rename_window_with_icon 'deploy';;
    docker*) tmux_window_renamer::rename_window_with_icon 'docker';;
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
function tmux_window_renamer::rename_window_precmd() {
  if tmux_window_renamer::should_auto_rename; then
    tmux_window_renamer::rename_window_with_icon 'terminal'
  fi
}

# Should the renamer automatically rename the window?
#
# If the window name has been changed by the user, don't rename it. Only rename
# the window if the current pane is the first pane. Otherwise, don't let any
# other panes automatically rename the window.
function tmux_window_renamer::should_auto_rename() {
  ! tmux_window_renamer::is_window_name_locked && tmux_window_renamer::is_first_pane
}
