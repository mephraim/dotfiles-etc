" Airline plugin settings

scriptencoding

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''

" Customize the tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tabs_label = '  '
let g:airline#extensions#tabline#show_close_button = 0

" Show the branch name, but not the number of changes
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0

" Enable trailing whitespace warnings
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = ''
let g:airline#extensions#whitespace#trailing_format = '⎵  [%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '▸ [%s]'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = "\uE725"
let g:airline_theme = 'base16_twilight'
