-- Bootstrap packer
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

vim.cmd("packadd packer.nvim")

-- Packer plugins
require('packer').startup(function(use)
  require('plugins.general')(use)
  require('plugins.git')(use)
  require('plugins.language-server')(use)
  require('plugins.nvim-tree')(use)
  require('plugins.pair-matching')(use)
  require('plugins.syntax')(use)
  require('plugins.telescope')(use)
  require('plugins.treesitter')(use)
  require('plugins.ui')(use)

  -- Have packer manage itself (this needs to be at the very end)
  use({ "wbthomason/packer.nvim", opt = true })

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Personal Plugins
require('plugins.personal.conceal-spaces')
