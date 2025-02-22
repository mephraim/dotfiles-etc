return {
  { "bogado/file-line" },
  { 'dyng/ctrlsf.vim' },
  { "michaeljsmith/vim-indent-object" },
  { "tpope/vim-characterize" },
  { "tpope/vim-commentary" },
  { "tpope/vim-cucumber" },
  { "tpope/vim-rails" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },

  -- Buffer Exploration
  {
    "jeetsukumaran/vim-buffergator",
    init = function()
      vim.cmd([[
        nnoremap <silent> <leader>be :BuffergatorToggle<CR>
      ]])
    end
  },
  {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    dependencies = { 'kkharji/sqlite.lua' }
  },
  {
    "vim-scripts/loremipsum",
    init = function()
      vim.cmd [[
        noremap <leader>lorem :Loremipsum<CR>
      ]]
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
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
        buftype = {
          nofile = {
            enabled = false,
          },
        },

        filetype = {
          -- Add overrides for codecompanion window
          codecompanion = {
            enabled = true,
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
    }
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        system_clipboard = {
          sync_with_ring = false,
        }
      })

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
}
