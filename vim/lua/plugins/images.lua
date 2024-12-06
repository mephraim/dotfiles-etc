return {
  {
    "3rd/image.nvim",
    opts = {}
  },
  {
    enabled = false,
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {},
    config = function()
      require("diagram").setup({
        integrations = {
          require("diagram.integrations.markdown"),
        },

        renderer_options = {
          mermaid = {
            background = "transparent",
            theme = "dark",
          }
        },
      })
    end
  }
}
