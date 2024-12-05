return {
  { "bogado/file-line" },
  { "michaeljsmith/vim-indent-object" },
  { "tpope/vim-characterize" },
  { "tpope/vim-commentary" },
  { "tpope/vim-cucumber" },
  { "tpope/vim-rails" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
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
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    dependencies = { 'kkharji/sqlite.lua' }
  }
}
