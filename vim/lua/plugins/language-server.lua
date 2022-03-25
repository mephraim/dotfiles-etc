lsp_installer = require("nvim-lsp-installer")

function config()
  installServers()
  setupServers()
end

function installServers() 
  -- These are the servers we want to install
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
    "remark_ls",
    "solargraph",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
  }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

function setupServers()
  lsp_installer.on_server_ready(function(server)
    print "I am ready "
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
  end)
end

return function(use)
  use {
    'neovim/nvim-lspconfig',
    requires = {
      { 'williamboman/nvim-lsp-installer' }
    },
    config = config
  }
end
