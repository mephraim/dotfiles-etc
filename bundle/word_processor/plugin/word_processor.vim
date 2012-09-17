" Make vim a little more usable for word processing stuff

function! s:turnOnWordProcessing()
  " Turn on softwrapping
  setlocal wrap

  " Wrap at spaces, rather than at any character
  setlocal linebreak

  " Display as much as possible of the last line
  setlocal display+=lastline

  " Turn on spelling checking
  setlocal spell spelllang=en_gb

  " Get rid of line numbers
  setlocal nonumber

  " Make sure vim doesn't screw up numbered lists
  setlocal formatoptions+=n

  " Set editor width to a readable 100 columns
  setlocal columns=100

  " Adds a little extra space on the left side
  setlocal foldcolumn=3

  " Add a little bit of extra linespacing
  setlocal linespace=3

  " Clear out any special showbreak symbols
  setlocal showbreak=

  " Make j and k work normally for soft wrapped lines
  noremap <buffer> j gj
  noremap <buffer> k gk

  " Make line navigation work normally for soft wrapped lines
  noremap <buffer> $ g$
  noremap <buffer> 0 g0
  noremap <buffer> ^ g^
  noremap <buffer> G G$

  " Make I, A, O work normally for soft wrapped lines
  noremap <buffer> I g0i
  noremap <buffer> A g$a

  " Make visual line select work for soft wrapped lines
  noremap <buffer> V g^vg$

  " Make delete work for soft wrapped lines
  noremap <buffer> dd g^dg$
  noremap <buffer> D dg$i<cr><esc>
  noremap <buffer> C dg$i<cr>

  " Add some mappings that will automatically add more frequent undo points
  inoremap . .<C-g>u
  inoremap ! !<C-g>u
  inoremap ? ?<C-g>u
  inoremap : :<C-g>u
endfunction

command! WordProcessorOn :call <SID>turnOnWordProcessing()
