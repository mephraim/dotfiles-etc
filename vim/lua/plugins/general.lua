return function(use)
  use "bogado/file-line"
  use "elzr/vim-json"
  use "jparise/vim-graphql"
  use "junegunn/vim-emoji"
  use "michaeljsmith/vim-indent-object"
  use "tpope/vim-characterize"
  use "tpope/vim-commentary"
  use "tpope/vim-rails"
  use "tpope/vim-repeat"
  use "tpope/vim-rhubarb"
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"

  -- Buffer Exploration
  use {
    "jeetsukumaran/vim-buffergator",
    config = function()
      vim.cmd([[
        nnoremap <leader>be :BuffergatorToggle<CR>
      ]])
    end
  }

  use {
    "dyng/ctrlsf.vim",
    cmd = { "CtrlSF" },
    config = function()
      vim.g.ctrlsf_auto_close = {
        normal = 0,
        compact = 0
      }
    end
  }

  use {
    "machakann/vim-highlightedyank",
    config = function()
      -- Set the highlight duration for the highlighted yank plugin
      vim.g.highlightedyank_highlight_duration = 3000
    end
  }

  use "vim-scripts/loremipsum"
  vim.cmd [[
    noremap <leader>lorem :Loremipsum<CR>
  ]]

  -- Try yode as a replacement for NarrowRgn
  use {
    "hoschi/yode-nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("yode-nvim").setup({})
    end
  }

  -- Vim Doge generates full documentation blocks
  use {
    "kkoomen/vim-doge",
    run = function()
      vim.cmd [[call doge#install()]]
    end
  }

  use {
    "vim-scripts/YankRing.vim",
    cmd = { "YankRing", "YRShow" }
  }

  -- Set up the yankring history location
  vim.g.yankring_history_dir = "~/dotfiles-etc/vim/tmp/yankring"

  -- Show the yankring
  vim.cmd [[noremap <leader>yr :YRShow<cr>]]
end
