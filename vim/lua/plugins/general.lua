return function(use)
  use "bogado/file-line"
  use "elzr/vim-json"
  use "jparise/vim-graphql"
  use "junegunn/vim-emoji"
  use "michaeljsmith/vim-indent-object"
  use "tpope/vim-characterize"
  use "tpope/vim-commentary"
  use "tpope/vim-cucumber"
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
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
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
    "gbprod/yanky.nvim",

    config = function()
      require("yanky").setup {
        system_clipboard = {
          sync_with_ring = false,
        },
      }

      require("telescope").load_extension("yank_history")

      -- Setup the suggested yank actions
      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

      -- Use yr to bring up the full yank history
      vim.keymap.set("n", "<leader>yr", "<cmd>Telescope yank_history<CR>")
    end
  }

  use {
    "echasnovski/mini.nvim",
    config = function()
      local indentscope = require('mini.indentscope')
      indentscope.setup({
        draw = {
          animation = indentscope.gen_animation('none')
        }
      })

      vim.g.miniindentscope_disable = true
      vim.keymap.set("n", "<leader>is", function()
        vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
      end)
    end
  }
end
