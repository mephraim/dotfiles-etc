return function(use)
  use "tpope/vim-fugitive"

  -- Better git commit log navigation
  use "gregsexton/gitv"

  -- Better git commit message display
  use "rhysd/committia.vim"

  vim.cmd [[
    let g:committia_hooks = {}
    function! g:committia_hooks.edit_open(info)
      " Additional settings
      setlocal spell

      " Scroll the diff window from insert mode
      " Map <C-n> and <C-p>
      imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
      imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
    endfunction
  ]]

  -- GitMessenger
  use "rhysd/git-messenger.vim"

  vim.cmd [[
    nnoremap <silent> <leader>gm :GitMessenger<CR>
  ]]

  use "sindrets/diffview.nvim"
end
