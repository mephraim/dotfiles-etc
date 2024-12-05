return function(use)
  use({
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              width = .35
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
        },
      })

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

    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    }
  })
end
