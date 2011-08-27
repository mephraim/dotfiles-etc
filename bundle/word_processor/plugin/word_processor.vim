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

  " Make j and k work normally for soft wrapped lines
  map <buffer> j gj
  map <buffer> k gk
endfunction

command! WordProcessorOn :call <SID>turnOnWordProcessing()
