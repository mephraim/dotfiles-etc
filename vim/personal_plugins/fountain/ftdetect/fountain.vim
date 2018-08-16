au BufRead,BufNewFile *.fountain call s:fountainSetup()

function! s:fountainSetup()
  let g:textplay_path = '~/Code/Textplay/textplay'

  " These settings have only been tested in Macvim
  if !has("gui_running")
    return
  end

  set filetype=fountain
  colorscheme fountain

  set guifont=Courier\ New:h18

  " Don't show the current mode
  set noshowmode

  " Don't expand concealed text in normal mode
  set concealcursor=n

  " Turn on softwrapping
  setlocal wrap

  " Wrap at spaces, rather than at any character
  setlocal linebreak

  " Display as much as possible of the last line
  setlocal display+=lastline

  " Turn on spelling checking
  setlocal spell spelllang=en_gb

  " Add a little bit of extra linespacing
  setlocal linespace=3

  " Clear out any special showbreak symbols
  setlocal showbreak=

  " Hide concealed text (underline markers, etc)
  set conceallevel=3

  " Make j and k work normally for soft wrapped lines
  noremap <buffer> j gj
  noremap <buffer> k gk

  execute 'AirlineToggle'
  set noruler

  " Use vimroom
  execute 'VimroomToggle'

  " Turn off signify
  let g:signify_disable_by_default = 1

  command! Preview :call s:preview()
endfunction

function! s:preview()
  let filename = tempname()
  echo system(g:textplay_path . ' < ' . expand('%') . ' > ' . filename . ' && open ' . filename)
endfunction
