return function(use)
  use "pangloss/vim-javascript"

  -- Configure JavaScript syntax highlighting
  vim.g.jsx_ext_required = 0
  vim.g.javascript_plugin_jsdoc = 1

  use "HerringtonDarkholme/yats.vim"
  use "jonsmithers/vim-html-template-literals"
end
