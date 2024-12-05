return {
  {
    "github/copilot.vim",

    init = function()
      vim.keymap.set('i', '<C-E>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })

      vim.g.copilot_no_tab_map = true
    end
  },

  {
    "olimorris/codecompanion.nvim",
    opts = {
      display = {
        chat = {
          window = {
            width = .40
          }
        }
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },

        inline = {
          adapter = "copilot",
        },
      }
    },

    init = function()
      local companionGroup = vim.api.nvim_create_augroup(
        "Conceal2Spaces", { clear = true })

      vim.api.nvim_create_autocmd(("BufEnter"), {
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "codecompanion" then
            vim.opt_local.number = false
          end
        end,
        group = companionGroup
      })
    end,

    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  }
}
