return function(use)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end
  }

  -- Use bufferline for tab configuration at the top
  use {
    "akinsho/bufferline.nvim",
    requires = "nvim-tree/nvim-web-devicons",
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
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
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
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup {
        relculright = true,
        -- Customize the fold column so that neovim doesn't show
        -- the fold level.
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = {"%s"}, click = "v:lua.ScSa"},
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
        }
      }
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
          conceal = true,
          format = {
            cmdline = { pattern = "^:", icon = " " },
            search_down = { kind = "search", pattern = "^/", icon = "", ft = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "", ft = "regex" },
            filter = { pattern = "^:%*s/+", icon = "$", ft = "sh" },
            lua = { pattern = "^:%s*lua%s+", icon = "", ft = "lua" },
          },
        },
        lsp = {
          hover = {
            enabled = false,
          },
          messages = {
            enabled = false
          },
          override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
          },
        },
        messages = {
          enabled = false
        },
        notify = {
          enabled = false
        },
        views = {
          cmdline_popup = {
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NoiceBorder,FloatBorder:NoiceFloat",
            },
          },
        },
      })
    end
  }
end
