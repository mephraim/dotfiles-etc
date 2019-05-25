local host="%m | "
local current_dir="$fg[blue]%3c%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_UNTRACKED="$fg[red]+$reset_color"
ZSH_THEME_GIT_PROMPT_ADDED="$fg[green]+$reset_color"
ZSH_THEME_GIT_PROMPT_MODIFIED="$fg[red]*$reset_color"
ZSH_THEME_GIT_PROMPT_RENAMED="$fg[green]≀$reset_color"
ZSH_THEME_GIT_PROMPT_DELETED="$fg[red]-$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]%B"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

function git_branch_pushed_status() {
 local current_branch=${ref#refs/heads/}
 local match_count="$(git branch --remote | grep -c ${current_branch})"

 if [ $current_branch != "master" ] && [ $match_count -gt 0 ]; then
   echo "$fg[green]↑$reset_color"
 fi
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  if [ -n "$(git status --porcelain)" ]; then
    local status_symbols="[$(git_prompt_status)] "
  else
    local status_symbols=""
  fi

  echo " | $(parse_git_dirty)${ref#refs/heads/}%{$reset_color%}%b ${status_symbols}$(git_branch_pushed_status)"
}

# Output the directory name.
function __pwd() {
  local output="$fg[blue]%3c%{$reset_color%}"
  echo "$output"
}

function __get_zsh_prompt() {
  echo "╭ ${host}%u$(__pwd)$(git_prompt_info)
╰▻ "
}

PROMPT='$(__get_zsh_prompt)'
