function TelescopeConfig()
  vim.cmd([[
    nmap <silent> <Space> :Telescope find_files<CR>
    nmap <silent> <C-Space> :Telescope buffers<CR>
    nmap <silent> <leader><Space> :Telescope live_grep<CR>
    nmap <silent> <leader>sym :Telescope lsp_document_symbols<CR>
  ]])

  local actions = require("telescope.actions")

  require("telescope").setup{
    defaults = {
      border = true,
      layout_strategy = 'flex', layout_config = {
        height = 0.7
      },
      mappings = {
        i = {
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
          ["<esc>"] = actions.close
        }
      },
      winblend = 4
    },

    pickers = {
      buffers = {
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer
          }
        }
      }
    }
  }
end

return function(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'kyazdani42/nvim-web-devicons'}
    },
    config = TelescopeConfig
  }
end
