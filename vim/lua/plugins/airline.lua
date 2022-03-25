return function(use) 
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  vim.g['airline_left_sep'] = ''
  vim.g['airline_left_alt_sep'] = ''

  -- Customize the tabline
  vim.g['airline#extensions#tabline#enabled'] = 1
  vim.g['airline#extensions#tabline#fnamemod'] = ':t'

  vim.g['airline#extensions#tabline#left_sep'] = ''
  vim.g['airline#extensions#tabline#left_alt_sep'] = ''

  vim.g['airline#extensions#tabline#buffer_idx_mode'] = 0
  vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
  vim.g['airline#extensions#tabline#show_buffers'] = 0
  vim.g['airline#extensions#tabline#show_splits'] = 0
  vim.g['airline#extensions#tabline#show_tab_count'] = 0
  vim.g['airline#extensions#tabline#show_tab_nr'] = 0
  vim.g['airline#extensions#tabline#tab_min_count'] = 0
  vim.g['airline#extensions#tabline#tabs_label'] = '  '
  vim.g['airline#extensions#tabline#show_close_button'] = 0

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
