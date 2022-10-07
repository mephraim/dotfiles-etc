function TelescopeConfig()
  vim.keymap.set('n', '<Space>', function()
    require("telescope.builtin").find_files({
      prompt_prefix="  "
    })
  end)

  vim.keymap.set('n', '<C-Space>', function()
    require("telescope.builtin").buffers({
      prompt_prefix=" ﬘ "
    })
  end)

  vim.keymap.set('n', '<leader><Space>', function()
    require("telescope.builtin").live_grep({
      prompt_prefix="  "
    })
  end)

  vim.keymap.set('n', '<leader>o', function()
    require("telescope.builtin").oldfiles({
      prompt_prefix="  "
    })
  end)

  vim.keymap.set('n', '<leader>sym', function()
    require("telescope.builtin").lsp_document_symbols({
      prompt_prefix="  "
    })
  end)

  local actions = require("telescope.actions")

  local telescope = require("telescope")
  telescope.setup {
    defaults = {
      border = true,
      layout_strategy = 'flex',
      layout_config = {
        height = 0.7,
        width = 0.9
      },
      mappings = {
        i = {
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
          ["<esc>"] = actions.close,

          -- This is a workaround so that folding will still work when files are
          -- opened with telescope.
          -- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-1195895807
          ["<CR>"] = function()
            vim.cmd [[:stopinsert]]
            vim.cmd [[call feedkeys("\<CR>")]]
          end
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

  telescope.load_extension("packer")
end

return function(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"kyazdani42/nvim-web-devicons"},
      {"nvim-telescope/telescope-packer.nvim"}
    },
    config = TelescopeConfig
  }
end
