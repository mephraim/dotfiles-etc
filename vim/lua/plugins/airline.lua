return function(use) 
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  vim.g['airline_left_sep'] = ''
  vim.g['airline_left_alt_sep'] = ''

  -- Show the branch name, but not the number of changes
  vim.g['airline#extensions#branch#enabled'] = 1
  vim.g['airline#extensions#hunks#enabled'] = 0

  -- Enable trailing whitespace warnings
  vim.g['airline#extensions#whitespace#enabled'] = 1
  vim.g['airline#extensions#whitespace#symbol'] = ''
  vim.g['airline#extensions#whitespace#trailing_format'] = '⎵  [%s]'
  vim.g['airline#extensions#whitespace#mixed_indent_format'] = '▸ [%s]'

  -- if not vim.g['airline_symbols'] then
  --   vim.g['airline_symbols'] = {}
  -- end

  -- vim.g['airline_symbols']['branch'] = '\uE725'
  vim.g['airline_theme'] = 'base16_vim'
end
