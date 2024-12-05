local ensured_ts_languages = {
  "arduino",
  "awk",
  "bash",
  "diff",
  "css",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "gitattributes",
  "dockerfile",
  "html",
  "http",
  "gitignore",
  "graphql",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "sql",
  "supercollider",
  "terraform",
  "typescript",
  "vim",
  "yaml"
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
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
        }
      }
    end
  },

  {
    "nvim-treesitter/playground",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter"
    }
  }
}
