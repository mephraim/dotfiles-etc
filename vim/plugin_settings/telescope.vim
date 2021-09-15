Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

nmap <silent> <Space> :Telescope find_files<CR>
nmap <silent> <C-Space> :Telescope buffers<CR>

function! TelescopeSetup()
lua << EOF
  local actions = require("telescope.actions")

  require("telescope").setup{
    defaults = {
      border = true,
      layout_strategy = 'flex',
      layout_config = {
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
EOF
endfunction
