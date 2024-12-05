return function(use)
  use "bogado/file-line"
  use "elzr/vim-json"
  use "jparise/vim-graphql"
  use "junegunn/vim-emoji"
  use "michaeljsmith/vim-indent-object"
  use "tpope/vim-characterize"
  use "tpope/vim-commentary"
  use "tpope/vim-cucumber"
  use "tpope/vim-rails"
  use "tpope/vim-repeat"
  use "tpope/vim-rhubarb"
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- use({
  --   "preservim/vim-markdown"
  -- })

  use({
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('render-markdown').setup({
          file_types = { 'codecompanion', 'markdown', 'quarto' },
          code = {
            left_pad = 2,
          },

          heading = {
            position = 'inline',
            sign = false,
            left_pad = 0,
            left_margin = 0,
            width = "block"
          },

          overrides = {
            -- Overrides for different buftypes, see :h 'buftype'
            buftype = {
              nofile = {
                padding = { highlight = 'NormalFloat' },
                sign = { enabled = false },
              },
            },

            filetype = {
              -- Add overrides for codecompanion window
              codecompanion = {
                render_modes = { 'i', 'n', 'c', 't' },
                anti_conceal = {
                  enabled = false
                },
                sign = { enabled = false },
                heading = {
                  backgrounds = {},
                  icons = { '', '󰭹 ', '󱙺 ', '', '', '' }
                }
              },
            },
          }
        })
      end
  })

  -- Buffer Exploration
  use {
    "jeetsukumaran/vim-buffergator",
    config = function()
      vim.cmd([[
        nnoremap <silent> <leader>be :BuffergatorToggle<CR>
      ]])
    end
  }

  use {
    "dyng/ctrlsf.vim",
    cmd = { "CtrlSF" },
    config = function()
      vim.g.ctrlsf_auto_close = {
        normal = 0,
        compact = 0
      }
    end
  }

  use {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        enable_named_colors = true,
        virtual_symbol = '●'
      })
    end
  }

  use "vim-scripts/loremipsum"
  vim.cmd [[
    noremap <leader>lorem :Loremipsum<CR>
  ]]

  -- Try yode as a replacement for NarrowRgn
  use {
    "hoschi/yode-nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("yode-nvim").setup({})
    end
  }

  -- Vim Doge generates full documentation blocks
  use {
    "kkoomen/vim-doge",
    run = function()
      vim.cmd [[call doge#install()]]
    end
  }

  use {
    "gbprod/yanky.nvim",

    config = function()
      require("yanky").setup {
        system_clipboard = {
          sync_with_ring = false,
        },
      }

      require("telescope").load_extension("yank_history")

      -- Setup the suggested yank actions
      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

      -- Use yr to bring up the full yank history
      vim.keymap.set("n", "<leader>yr", "<cmd>Telescope yank_history<CR>")
    end
  }
end
