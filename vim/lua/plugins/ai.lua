return function(use)
  use({
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
            render_headers = false
          },

          inline = {
            adapter = "copilot",
          },
        },
      })
    end,

    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    }
  })
end
