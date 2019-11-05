" Plugin settings for fzf

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Map the spacebar in normal mode to a custom FZF command
nmap <silent> <Space> :call pretty_fzf#OpenFiles()<CR>

" Open the fzf buffer explorer with ctrl + space
nmap <silent> <C-Space> :Buffers<CR>

" Store per command history
let g:fzf_history_dir = '~/dotfiles-etc/vim/tmp/fzf-history'

" Set the fzf window to the bottom 20% of the screen
let g:fzf_layout = { 'down': '~20%' }

" In neovim, open the fzf browser as a floating window
" with some extra customized settings.
"
" (source: https://github.com/junegunn/fzf.vim/issues/664)
if has('nvim')
  Plug '~/dotfiles-etc/vim/personal_plugins/pretty_fzf'
end
