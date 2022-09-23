local ensured_ts_languages = {
  "bash",
  "css",
  "html",
  "http",
  "gitignore",
  "graphql",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "sql",
  "supercollider",
  "typescript",
  "vim",
  "yaml"
}

return function(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update {
        with_sync = true
      }
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ensure_installed = ensured_ts_languages,
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = {"BufWrite", "CursorHold"},
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = {
                query = "@function.outer",
                desc = "Select outer part of a function"
              },
              ["if"] = {
                query = "@function.inner",
                desc = "Select inner part of a function"
              },
              ["ac"] = {
                query = "@class.outer",
                desc = "Select outer part of a class region"
              },
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region"
              },
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sp"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>SP"] = "@parameter.inner",
            },
          },
        },
      }
    end
  }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    },
    config = function()
      require('refactoring').setup({})

      -- Display a telescope window with the extract options
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true }
      )

      -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
      vim.api.nvim_set_keymap("n", "<leader>rv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true })

      -- Remap in visual mode will print whatever is in the visual selection
      vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

      -- Cleanup function: this remap should be made in normal mode
      vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = 'nvim-treesitter',
    requires = {
      "nvim-treesitter"
    }
  }

  use {
    "nvim-treesitter/playground",
    after = 'nvim-treesitter',
    requires = {
      "nvim-treesitter"
    }
  }
end
