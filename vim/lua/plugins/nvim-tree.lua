return function(use)
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },

    config = function()
      require('nvim-tree').setup {
        hijack_netrw = false,
        hijack_directories = {
          enable = false,
        }
      }

      vim.cmd([[
        nnoremap <silent> <leader>nn :NvimTreeToggle<CR>
      ]])
    end
  }
end
