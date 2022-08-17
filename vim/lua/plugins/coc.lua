function AfterCocInstall()
  vim.cmd [[call coc#util#install()]]
end

function SetupAutoCommands()
  vim.cmd [[
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
  ]]
end

function SetupCompletionMappings()
  -- Setup the tab key to move through the suggested items
  vim.cmd [[
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  ]]

  -- Setup the return key to select the current item
  vim.cmd [[
    inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
  ]]
end

return function(use)
  use {
    "neoclide/coc.nvim",
    run = AfterCocInstall
  }

  vim.g.coc_global_extensions = {
    'coc-css',
    'coc-emoji',
    'coc-json',
    'coc-pyls',
    'coc-solargraph',
    'coc-tsserver',
    'coc-ultisnips',
    'coc-vimlsp',
    'coc-yaml'
  }

  vim.g.coc_node_path = '~/.asdf/installs/nodejs/16.14.2/bin/node'

  SetupAutoCommands()
  SetupCompletionMappings()
end
