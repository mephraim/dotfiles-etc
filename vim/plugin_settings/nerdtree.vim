" Plugin settings for NERDTree
scriptencoding

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

noremap <silent> <leader>n :NERDTreeToggle<CR>

" Show NERDTree when opening what would normally be a Netrw window
let NERDTreeHijackNetrw = 1

" Hide the default "Press help for ?" at the top
let NERDTreeMinimalUI = 1

" Always show hidden files
let NERDTreeShowHidden=1

" Custom git indicators
let g:NERDTreeIndicatorMapCustom = {
      \ 'Modified'  : '🔺',
      \ 'Staged'    : '👍',
      \ 'Untracked' : '+',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Deleted'   : '❌',
      \ 'Dirty'     : '🔺',
      \ 'Clean'     : '✔︎',
      \ 'Ignored'   : '☒',
      \ 'Unknown'   : '?'
      \ }

augroup nerdTreeAutoCommands
  au!

  " Refresh the NERDTree when entering the NERDTree buffer
  " From here: https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html
  function! NERDTreeRefresh()
    if &filetype ==? 'nerdtree'
      " For some reason, the refresh needs to be performed twice to get
      " all of the icons to render correctly
      silent exe substitute(mapcheck('R'), '<CR>', '', '')
      silent exe substitute(mapcheck('R'), '<CR>', '', '')
    endif
  endfunction

  autocmd BufEnter * call NERDTreeRefresh()
augroup END
