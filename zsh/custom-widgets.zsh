FZF_PREVIEW_WINDOW="bottom:70%"
FZF_PREVIEW_BINDINGS="ctrl-f:preview-page-down,ctrl-b:preview-page-up"

# Join the lines from the fzf output
#
# Without piping the fzf result through this, there will be an extra space
# before the resulting item.
fzf-join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

# Is the current directory a git repo?
is-in-git-repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Use fzf to browse a list of branches
fzf-git-branch() {
  # Don't do anything if we're not in a git repo
  is-in-git-repo || return

  git branch --color=always | \
    fzf --reverse --ansi --preview-window="$FZF_PREVIEW_WINDOW" \
    --preview 'git log --stat --color=always $(echo {} | sed "s/*//")' \
    --bind "$FZF_PREVIEW_BINDINGS" \
}

# Create a zsh widget and bind it to Ctrl-G/Ctrl-B
fzf-git-branch-widget() LBUFFER+=$(fzf-git-branch | fzf-join-lines)
zle -N fzf-git-branch-widget
bindkey '^g^b' fzf-git-branch-widget

# Use fzf to browse a list of commit hashes
fzf-git-commit-hash() {
  # Don't do anything if we're not in a git repo
  is-in-git-repo || return

  # Use FZF to pick a short commit hash
  local result=$(git log --oneline --color=always | \
    fzf --reverse --ansi --preview-window="$FZF_PREVIEW_WINDOW" \
    --preview 'git show --color=always $(echo {} | cut -f 1 -d " ")' \
    --bind "$FZF_PREVIEW_BINDINGS" | \
    cut -f 1 -d " ")

  # If there was a chosen fzf result, use it to find the full commit hash
  if [[ "$result" != "" ]]; then
    echo $(git log "${result}" --pretty=format:"%H" -n 1)
  fi
}

# Create a zsh widget and bind it to Ctrl-G/Ctrl-H
fzf-git-commit-hash-widget() LBUFFER+=$(fzf-git-commit-hash | fzf-join-lines)
zle -N fzf-git-commit-hash-widget
bindkey '^g^h' fzf-git-commit-hash-widget

fzf-git-tag() {
  # Don't do anything if we're not in a git repo
  is-in-git-repo || return

  # Show git tags sorted by version
  git tag -l --sort=-version:refname | \
    fzf --reverse --ansi --preview-window="$FZF_PREVIEW_WINDOW" \
    --preview 'git show --color=always $(echo {} | cut -f 1 -d " ")' \
    --bind "$FZF_PREVIEW_BINDINGS" \
}

# Create a zsh widget and bind it to Ctrl-G/Ctrl-H
fzf-git-tag-widget() LBUFFER+=$(fzf-git-tag | fzf-join-lines)
zle -N fzf-git-tag-widget
bindkey '^g^t' fzf-git-tag-widget
