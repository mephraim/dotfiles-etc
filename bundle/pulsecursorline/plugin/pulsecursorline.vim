" Pulses the cursorline
" Inspired by Steve Losh: https://bitbucket.org/sjl/dotfiles/src/372c5316463a/vim/.vimrc#cl-1458
function! pulsecursorline#Pulse()
  setlocal cursorline
  let old_hi = s:GetCurrentHighlight()

  let colors = ["#2a2a2a",
              \ "#333333",
              \ "#3a3a3a",
              \ "#444444",
              \ "#4a4a4a",
              \ "#444444",
              \ "#3a3a3a",
              \ "#333333",
              \ "#2a2a2a" ]

  for color in colors
    call s:PulseColor(color)
  endfor

  execute 'hi ' . old_hi

  setlocal nocursorline
endfunction

function! s:GetCurrentHighlight()
  redir => old_hi
    silent execute 'hi CursorLine'
  redir END

  let old_hi = split(old_hi, '\n')[0]
  let old_hi = substitute(old_hi, 'xxx', '', '')

  return old_hi
endfunction

function! s:PulseColor(color)
  exec "hi CursorLine guibg=" . a:color
  redraw
  sleep 15m
endfunction
