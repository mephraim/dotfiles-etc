-- These are the language servers we'd like to use
local servers = {
  "awk_ls",
  "bashls",
  "cssls",
  "dockerls",
  "docker_compose_language_service",
  "eslint",
  "graphql",
  "html",
  "jsonls",
  "lemminx",
  "pyright",
  "solargraph",
  "lua_ls",
  "tsserver",
  "vimls",
  "yamlls",
}

-- These are the symbols to use for diagnostic signs
-- and virtual text.
local diagnostic_symbols = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function GetDiagnosticConfig(virtual_lines)
  if virtual_lines then
    return {
      virtual_lines = true,
      virtual_text = false
    }
  end

  -- Return a diagnostic symbol for the given severity
  local function get_prefix_for_diagnostic(severity)
    if severity == vim.diagnostic.severity.ERROR then
      return diagnostic_symbols.Error
    end

    if severity == vim.diagnostic.severity.WARN then
      return diagnostic_symbols.Warn
    end

    if severity == vim.diagnostic.severity.INFO then
      return diagnostic_symbols.Info
    end

    if severity == vim.diagnostic.severity.HINT then
      return diagnostic_symbols.Hint
    end

    return diagnostic_symbols.Warn
  end

  return {
    virtual_lines = false,

    virtual_text = {
      format = function(diagnostic)
        local prefix = get_prefix_for_diagnostic(diagnostic.severity)
        return string.format("%s %s", prefix, diagnostic.message)
      end,

      spacing = 0
    }
  }
end

function Config()
  require("mason").setup()

  SetupServers()
  SetupMappings()
  SetupUI()
  SetupCompletion()
  SetupDiagnosticFloat()
end

function SetupMappings()
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

function SetupServers()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  require("mason-lspconfig").setup_handlers({
    function (server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities
      }
    end,

    ["html"] = function()
      require('lspconfig').html.setup {
        capabilities = capabilities,
        -- By default, the html language server doesn't look at erb files, so we
        -- need to override the filetypes
        filetypes = { "html", "eruby" }
      }
    end,

    ["lua_ls"] = function ()
      require('lspconfig').lua_ls.setup {
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
  local luasnip = require('luasnip')

  return {
    -- Tab forward through the options
     ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Tab backward through the options
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Navigate options with the arrow keys
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

    -- Move forward through the options with ctrl-n
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

    -- Move backward through the options with ctrl-p
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

    -- Use ctrl-b and ctrl-f to scroll the docs window
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

    -- Make a selection with the return key
    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),

    -- Close the menu with ctrl-e
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
  }
end

function SetupCompletion()
  -- nvim-cmp setup
  local cmp = require('cmp')
  cmp.setup {
    window = {
      documentation = {
        max_height = 80,
        max_width = 60
      },
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    -- Setup key mappings for the completion menu
    -- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
    mapping = GetCmpMaps(),

    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'emoji' }
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
  for type, icon in pairs(diagnostic_symbols) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config(GetDiagnosticConfig())

  -- Add a border to the hover documenation windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      max_width = 120
    }
  )
end

function SetupDiagnosticFloat()
  function OpenDiagnosticFloatWindow()
    -- Don't open the float if there's an existing float window
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end

    vim.diagnostic.open_float(0, {
      focusable = false,
      header = " Diagnostics",
      pad_top = 1,
      pad_bottom = 1,
      scope = "cursor",
      wrap = true,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end

  vim.api.nvim_create_augroup("LSPDiagnosticsFloat", {
    clear = true
  })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = OpenDiagnosticFloatWindow,
    group = "LSPDiagnosticsFloat",
  })
end


return function(use)
  local enable_virtual_lines = false

  use {
    "williamboman/mason.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "rcarriga/nvim-notify",
      "williamboman/mason-lspconfig.nvim"
    },
    config = Config
  }

  -- For autocompletions
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim"
    }
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets"
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("ruby", {"rails"})
    end
  }

  -- Trouble allows us to browse all of the lint and error messages
  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})

      vim.cmd [[
        nnoremap <leader>xx <cmd>TroubleToggle document_diagnostics<cr>
      ]]

      vim.cmd [[
        nnoremap <leader>rf <cmd>TroubleToggle lsp_references<cr>
      ]]
    end
  }

  -- Split diagnostic messages across multiple lines
  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config(GetDiagnosticConfig())

      vim.keymap.set("", "<Leader>ll", function()
        require("lsp_lines").setup()

        enable_virtual_lines = not enable_virtual_lines
        vim.diagnostic.config(GetDiagnosticConfig(enable_virtual_lines))
      end,
        { desc = "Toggle lsp_lines" }
      )
    end
  }

  -- Hook the neovim select menu up so it uses Telescope
  use {
    "stevearc/dressing.nvim",
    config = function()
      require('dressing').setup({
        select = {
          telescope = require('telescope.themes').get_cursor({
            prompt_prefix = "  "
          })
        }
      })
    end
  }

  -- Provides a fancier code action menu that shows more context
  use {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu"
  }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end
  }
end
