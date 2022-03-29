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

return require('packer').startup(function(use)
  require('plugins.airline')(use)
  require('plugins.coc')(use)
  require('plugins.general')(use)
  require('plugins.git')(use)
  require('plugins.language-server')(use)
  require('plugins.nvim-tree')(use)
  require('plugins.pair-matching')(use)
  require('plugins.syntax')(use)
  require('plugins.telescope')(use)
  require('plugins.ui')(use)

  -- Have packer manage itself (this needs to be at the very end)
  use({ "wbthomason/packer.nvim", opt = true })

  if vim.env.LSP_COMPLETION then
    print('Disable COC')
    vim.cmd [[autocmd BufAdd * let b:coc_enabled=0]]
  end

  if packer_bootstrap then
    require('packer').sync()
  end
end)
