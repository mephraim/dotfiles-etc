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
  SetupCompletion()
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
  vim.api.nvim_set_keymap('n', 'rn', '<cmd>Lspsaga rename<CR>', opts)
  vim.api.nvim_set_keymap('n', 'ca', '<cmd>CodeActionMenu<CR>', opts)
  vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

function SetupServers()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  require("mason-lspconfig").setup_handlers({
    function (server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities
      }
    end,

    ["sumneko_lua"] = function ()
      require('lspconfig').sumneko_lua.setup {
        capabilities = capabilities,
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

function GetCmpMaps()
  local replaceTermcodes = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local cmp = require('cmp')
  return {
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(replaceTermcodes("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(replaceTermcodes("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),

    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( replaceTermcodes("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( replaceTermcodes("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end
    }),

    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(replaceTermcodes('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),

    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(replaceTermcodes('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),

    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    })
  }
end

function SetupCompletion()
  -- nvim-cmp setup
  local cmp = require('cmp')
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },

    -- Setup key mappings for the completion menu
    -- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
    mapping = GetCmpMaps(),

    sources = {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'cmdline' },
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        return require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50
        })(entry, vim_item)
      end,
    },

    experimental = {
      ghost_text = true
    }
  }

  -- Enable completion for / search
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Enable completion for ? search
  cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Enable completion for : commands
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Customize syntax highlighting for the completion menu
  vim.cmd [[
    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080

    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6

    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE

    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0

    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
  ]]
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
      prefix = '﯎'
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
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind.nvim"
    }
  }

  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-path'

  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'

  -- Snippets
  use {
    "SirVer/ultisnips",
    requires = {
      -- A nice collection of existing snippets
      "honza/vim-snippets",

      -- Required to connect ultisnips to nvim-cmp
      "quangnguyen30192/cmp-nvim-ultisnips"
    },

    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }

  -- Trouble allows us to browse all of the lint and error messages
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

  -- LSPSaga adds some fanciness to diagnostic and LSP windows
  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require("lspsaga").init_lsp_saga({
        code_action_lightbulb = {
          enable = false,
          sign = false,
          enable_in_insert = false,
          virtual_text = false,
        }
      })

      vim.cmd [[
        highlight! LSOutlinePreviewBorder guifg=#555555
        highlight! LspSagaAutoPreview guifg=#555555
        highlight! LspSagaDefPreviewBorder guifg=#555555
        highlight! LspSagaHoverBorder guifg=#555555
        highlight! LspSagaLspFinderBorder guifg=#555555
        highlight! LspSagaRenameBorder guifg=#555555
      ]]
    end,
  }

  use {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu"
  }
end
