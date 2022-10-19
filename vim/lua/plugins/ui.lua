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

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        provider_selector = function()
          return {'treesitter', 'indent'}
        end
      })

      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)

      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end
  }

  use {
    "folke/noice.nvim",
    event = "VimEnter",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          icons = {
            ["/"] = { icon = "", hl_group = "DiagnosticWarn" },
            ["?"] = { icon = "", hl_group = "DiagnosticWarn" },
            [":"] = { icon = " ", firstc = false },
          },
        },
        messages = {
          enabled = false
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          }
        },
        views = {
          cmdline_popup = {
            border = {
              style = "none",
              padding = { 1, 2 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NoiceFloat,FloatBorder:NoiceBorder",
            },
          },
        },
      })
    end
  }
end
