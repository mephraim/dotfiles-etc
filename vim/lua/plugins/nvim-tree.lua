function config()
  vim.cmd([[
    nnoremap <leader>n :NvimTreeToggle<CR>
  ]])
end

return function(use)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = config
  }
end
