-- Custom icons for suggestion types
local kind_icons = {
  Class = "ﴯ",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "ﰠ",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = ""
}

-- These are the language servers we'd like to use
local servers = {
  "bashls",
  "cssls",
  "cucumber_language_server",
  "dockerls",
  "eslint",
  "graphql",
  "html",
  "jsonls",
  "lemminx",
  "pyright",
  "solargraph",
  "sumneko_lua",
  "tsserver",
  "vimls",
  "yamlls",
}

function ConfigLanguageServers()
  require("mason").setup()

  SetupServers()
  SetupMappings()
  SetupUI()

  if (vim.env.LSP_COMPLETION) then
    print('LSP completion enabled')
    SetupCompletion()
  else
    print('LSP completion not enabled')
  end
end

function SetupMappings()
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

function SetupServers()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "cssls",
      "cucumber_language_server",
      "dockerls",
      "eslint",
      "graphql",
      "html",
      "jsonls",
      "lemminx",
      "pyright",
      "solargraph",
      "sumneko_lua",
      "tsserver",
      "vimls",
      "yamlls",
    },

    automatic_installation = true
  })

  require("mason-lspconfig").setup_handlers({
    function (server_name) -- default handler (optional)
      require('lspconfig')[server_name].setup {}
    end,

    ["sumneko_lua"] = function ()
      require('lspconfig').sumneko_lua.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
    end
  })
end

function SetupCompletion()
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local lspconfig = require('lspconfig')

  -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
    }
  end

  -- luasnip setup
  local luasnip = require('luasnip')

  -- nvim-cmp setup
  local cmp = require 'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    -- Setup key mappings for the completion menu
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),

      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },

      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,

      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'cmdline' }
    },

    formatting = {
      format = function(entry, vim_item)
        -- Concatenate the kind icon and completion kind
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name]

        return vim_item
      end
    },

    experimental = {
      ghost_text = true
    }
  }
end

function SetupUI()
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = {
      prefix = '●'
    }
  })
end

return function(use)
  local enable_virtual_lines = false

  use {
    "williamboman/mason.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      ConfigLanguageServers()
    end
  }

  -- For autocompletions
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-path'

  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'

 -- Snippets source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'

  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'

  -- Setup linting
  use {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        css = { "stylelint" },
        javascript = { "eslint" },
        sh = { "shellcheck" }
      }
    end
  }

  vim.cmd [[au BufWritePost <buffer> lua require('lint').try_lint()]]

  -- Trouble allows us to browse all of the lint and erorr messages
  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("trouble").setup{}

      vim.cmd [[
        nnoremap <leader>xx <cmd>TroubleToggle<cr>
      ]]

      vim.cmd [[
        nnoremap <leader>rf <cmd>TroubleToggle lsp_references<cr>
      ]]
    end
  }

  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_lines = enable_virtual_lines
      })

      vim.keymap.set( "", "<Leader>ll", function()
        require("lsp_lines").setup()

        enable_virtual_lines = not enable_virtual_lines
        vim.diagnostic.config({
          virtual_lines = enable_virtual_lines,
          virtual_text = not enable_virtual_lines
        })
      end,
        { desc = "Toggle lsp_lines" }
      )
    end
  }
end
