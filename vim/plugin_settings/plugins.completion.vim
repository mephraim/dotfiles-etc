" Settings for completiong plugins (Coc, etc)
"
" COC {{{
  let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-emoji',
    \ 'coc-json',
    \ 'coc-pyls',
    \ 'coc-solargraph',
    \ 'coc-tsserver',
    \ 'coc-ultisnips',
    \ 'coc-vimlsp',
    \ 'coc-yaml'
  \ ]

  let g:coc_node_path = '~/.asdf/installs/nodejs/14.4.0/bin/node'

  function! AfterCocInstall(info)
    if a:info.status ==# 'installed' || a:info.force
      call coc#util#install()
      call InstallLanguageServers()
    endif
  endfunction

  " Install any additional language servers that need custom setup.
  function! InstallLanguageServers()
    " Bash language server
    !npm i -g bash-language-server

    " Dockerfile language server
    !npm install -g dockerfile-language-server-nodejs

    " HTML language server
    !npm install --global vscode-html-languageserver-bin

    " Solargraph for Ruby completion
    !gem install solargraph
  endfunction

  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " Setup the tab key to move through the suggested items
  inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

  " Setup the return key to select the current item
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" }}}1

" Autocommands {{{1
  function! SetupCocMappings()
    nmap gd <Plug>(coc-definition)
    nmap <leader>rn <Plug>(coc-rename)
    nmap <leader>ref <Plug>(coc-references-used)
  endfunction

  augroup vimrcCompletionAutoCommands
    au!

    autocmd BufEnter * call SetupCocMappings()

    " Hide the preview window after a completion is done
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  augroup END
" }}}1
