" Git related plugin settings

Plug 'tpope/vim-fugitive'

" Better git commit log navigation
Plug 'gregsexton/gitv'

" Committia {{{1
  " Better git commit message display
  Plug 'rhysd/committia.vim'

  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
  endfunction
" }}}1

" Gitgutter {{{1
  Plug 'airblade/vim-gitgutter'

  " Customize git gutter signs
  let g:gitgutter_sign_added = '⎸'
  let g:gitgutter_sign_modified = '⎸'
  let g:gitgutter_sign_removed = '⎸'
  let g:gitgutter_sign_removed_first_line = '⎸'
  let g:gitgutter_sign_modified_removed = '⎸'

  let g:gitgutter_highlight_lines = 1
" }}}1
