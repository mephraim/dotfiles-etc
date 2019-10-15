" A floating terminal window from here:
" https://www.reddit.com/r/neovim/comments/di41cm/a_floating_terminal_with_borderpadding/

let s:float_term_border_win = 0
let s:float_term_win = 0

" A floating terminal window from here:
" https://www.reddit.com/r/neovim/comments/di41cm/a_floating_terminal_with_borderpadding/
function! s:floatingTerminal()
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)

  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }

  let border_buf = nvim_create_buf(v:false, v:true)
  let s:float_term_border_win = nvim_open_win(border_buf, v:true, border_opts)

  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)

  " Styling
  hi FloatTermNormal term=None guibg=#2d3d45
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatTermNormal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:FloatTermNormal')

  terminal
  startinsert

  " Close border window when terminal window close
  autocmd CursorMoved * ++once call nvim_win_close(s:float_term_border_win, v:true)
endfunction

command! FloatingTerminal call s:floatingTerminal()
