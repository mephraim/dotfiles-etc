return function(use)
  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
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
end
