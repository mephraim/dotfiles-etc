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
