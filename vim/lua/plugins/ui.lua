return function(use)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Use bufferline for tab configuration at the top
  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    -- There's a breaking change after this commit, so stick with it until the
    -- issue is fixed.
    commit = "af158e4477a08be3645faf91cfb772f898c132f0",
    config = function()
      require("bufferline").setup {
        options = {
          mode = "tabs",
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              highlight = "Directory",
              text_align = "left"
            }
          }
        },
      }
    end
  }

  -- Add smooth scrolling
  use 'psliwka/vim-smoothie'

  -- Lualine status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine-config')

      vim.cmd [[
        set laststatus=3
        set noshowmode
      ]]
    end
  }

  use {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require('notify')
      notify.setup({
        timeout = 2000
      })

      vim.notify = notify
    end
  }
end
