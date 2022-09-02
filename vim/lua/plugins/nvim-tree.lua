return function(use)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },

    config = function()
      require('nvim-tree').setup {}

      vim.cmd([[
        nnoremap <silent> <leader>n :NvimTreeToggle<CR>
      ]])
    end
  }
end
