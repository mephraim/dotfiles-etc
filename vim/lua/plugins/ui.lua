return {
  { 
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  { "nvim-tree/nvim-web-devicons" },

  -- Use bufferline for tab configuration at the top
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
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
  },

  -- Add smooth scrolling
  { 'psliwka/vim-smoothie' },

  {
    "rcarriga/nvim-notify",
    opts = { timeout = 2000 },
    init = function()
      vim.notify = require('notify')
    end
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
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
  },

  {
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
  },

  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
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
      }
    }
  },

  -- Hook the neovim select menu up so it uses Telescope
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        select = {
          get_config = function(opts)
            -- When executing a code action, use the cursor theme
            -- so that the window opens up right next to the cursor's
            -- current position.
            if opts.kind == 'codeaction' then
              return {
                backend = 'telescope',
                telescope = require('telescope.themes').get_cursor({
                  prompt_prefix = "  "
                })
              }
            end
          end,

          telescope = require('telescope.themes').get_dropdown({
            prompt_prefix = "  "
          })
        }
      })
    end,

    requirements = {
      "nvim-telescope/telescope.nvim"
    }
  }
}
