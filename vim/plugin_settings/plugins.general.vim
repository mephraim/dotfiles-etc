call plug#begin('~/dotfiles-etc/vim/plugged')

Plug 'bogado/file-line'
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'
Plug 'junegunn/vim-emoji'
Plug 'markonm/traces.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

" BufExplorer {{{1
  Plug 'vim-scripts/bufexplorer.zip'

  " Show [No Name] buffers, to make them easier to delete.
  let g:bufExplorerShowNoName = 1

  " Don't show the help screen at the top
  let g:bufExplorerDefaultHelp = 0
" }}}1

" CtrlSF {{{1
  Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
  let g:ctrlsf_auto_close = {
    \ 'normal' : 0,
    \ 'compact': 0
  \}
" }}}1

" Devicons {{{1
  Plug 'ryanoasis/vim-devicons'

  let g:DevIconsEnableFolderExtensionPatternMatching = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
  let g:DevIconsDefaultFolderOpenSymbol = ''
" }}}1

" Highlightedyank {{{1
  Plug 'machakann/vim-highlightedyank'
  " Set the highlight duration for the highlighted yank plugin
  let g:highlightedyank_highlight_duration = 3000
" }}}1

" Loremipsum {{{1
  Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
  " Quickly generate some lorem ipsum text
  noremap <leader>lorem :Loremipsum<CR>
" }}}1

" NarrowRegion {{{1
  Plug 'chrisbra/NrrwRgn', { 'on': 'NarrowRegion' }
  let g:nrrw_rgn_hl = 'NarrowRegion'
" }}}1

" Open/Close Matching {{{1
  " Automatically close tags
  Plug 'alvan/vim-closetag'

  let g:closetag_filetypes = 'eruby,html,javascript,javascript.jsx,xhtml'

  let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
    \ 'javascript.jsx': 'jsxRegion,litHtmlRegion',
    \ 'javascript':     'litHtmlRegion',
    \ 'typescript':     'litHtmlRegion',
    \ }

  " Highlight closing quotes, parens, tags, etc
  Plug 'andymass/vim-matchup'

  " In Neovim, display offscreen matches in a popup
  if has('nvim')
    let g:matchup_matchparen_offscreen = { 'method': 'popup' }
  endif

  " Highlight the closing tag
  " This plugin handles some extra cases that Matchup doesn't handle yet.
  Plug 'Valloric/MatchTagAlways'
  let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'eruby' : 1,
    \ 'javascript' : 1
  \}
" }}}1

" Syntax Highlighting / Languages {{{
  Plug 'pangloss/vim-javascript'

  " Configure JavaScript syntax highlighting
  let g:jsx_ext_required = 0
  let g:javascript_plugin_jsdoc = 1

  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'jonsmithers/vim-html-template-literals'
" }}}1

" Snippets {{{1
  Plug 'SirVer/ultisnips'

  " Snippets are separated from the snippet engine
  Plug 'honza/vim-snippets'

  " Override the default expansion since we're also using tab for completion
  let g:UltiSnipsExpandTrigger = '<C-Space>'

  " Set a custom snippets directory
  let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

  " Vim Doge generates full documentation blocks
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

  " Update the forward and backward mappings to match UltiSnips
  let g:doge_mapping_comment_jump_backward = '<C-K>'
  let g:doge_mapping_comment_jump_forward = '<C-J>'
" }}}1

" YankRing {{{1
  Plug 'vim-scripts/YankRing.vim'

  " Set up the yankring history location
  let g:yankring_history_dir = '~/dotfiles-etc/vim/tmp/yankring'

  " Override the default yankring cycling keys
  " This prevents a conflict with the ctrlp plugin
  let g:yankring_replace_n_pkey = '<m-p>'
  let g:yankring_replace_n_nkey = '<m-n>'

  " Show the yankring
  noremap <leader>yr :YRShow<cr>
" }}}1

source ~/dotfiles-etc/vim/plugin_settings/airline.vim
source ~/dotfiles-etc/vim/plugin_settings/ale.vim
source ~/dotfiles-etc/vim/plugin_settings/telescope.vim
source ~/dotfiles-etc/vim/plugin_settings/git.vim
source ~/dotfiles-etc/vim/plugin_settings/nerdtree.vim
source ~/dotfiles-etc/vim/plugin_settings/plugins.completion.vim
source ~/dotfiles-etc/vim/plugin_settings/plugins.prose.vim

call plug#end()

call TelescopeSetup()
