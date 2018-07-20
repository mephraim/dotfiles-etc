" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Plug setup {{{1
  " Make sure Vundle ftplugins are properly installed by disabling then
  " re-enabling file type plugins.
  filetype off

  call plug#begin('~/.vim/plugged')

  " Hosted plugins
  Plug 'Valloric/MatchTagAlways'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
  Plug 'airblade/vim-gitgutter'
  Plug 'briancollins/vim-jst'
  Plug 'chrisbra/Colorizer'
  Plug 'chrisbra/NrrwRgn'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dyng/ctrlsf.vim'
  Plug 'godlygeek/tabular'
  Plug 'gregsexton/gitv'
  Plug 'jaxbot/selective-undo.vim'
  Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/vim-emoji'
  Plug 'kablamo/vim-git-log'
  Plug 'machakann/vim-highlightedyank'
  Plug 'markonm/traces.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mileszs/ack.vim'
  Plug 'mxw/vim-jsx'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'pangloss/vim-javascript'
  Plug 'plasticboy/vim-markdown'
  Plug 'reedes/vim-colors-pencil'
  Plug 'reedes/vim-pencil'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' }
  Plug 'shime/vim-livedown'
  Plug 'shinokada/dragvisuals.vim'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-sleuth'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/SyntaxAttr.vim'
  Plug 'vim-scripts/YankRing.vim'
  Plug 'vim-scripts/bufexplorer.zip'
  Plug 'vim-scripts/loremipsum'
  Plug 'vim-scripts/matchit.zip'
  Plug 'vim-scripts/repeat.vim'
  Plug 'vim-scripts/ruby.vim'
  Plug 'vim-scripts/surround.vim'
  Plug 'w0rp/ale'
  Plug 'zefei/vim-colortuner'

  call plug#end()
" End Vundle setup
" }}}1

" Syntax and colorscheme {{{1
  " Switch syntax highlighting on when the terminal has colors
  " or when a GUI is running.
  if &t_Co > 2 || has("gui_running")
    syntax on
  endif

 if has("gui_running")
    colorscheme twilight256
  else
    " Tell the terminal to use 256 colors
    let &t_Co=256

    " Use a nice 256 color colorscheme
    colorscheme twilight256
  endif

  " Load in any customizations to the stock colorschemes
  runtime! colors/custom/*.vim
" End syntax and colorscheme
" }}}1


" Tab and indent related settings {{{1
  set expandtab       " Set up spaces as tabs
  set shiftround      " When at 3 spaces, and I hit > ... go to 4, not 5
  set shiftwidth=2    " Each step of autoindent = 2 spaces
  set smartindent     " Indent based on the previous line
  set smarttab        " Tab at start of line = shiftwidth, otherwise softtabstop
  set softtabstop=2   " 1 "soft tab" = 2 spaces
  set tabstop=2       " 1 tab will count for 2 spaces
" End tab and indent related settings
" }}}1


" Assorted configuration options {{{1
  set fillchars=fold:┈,vert:⎸ " Customize the fill character for folds
  set hidden            " Allow buffer switching without saving
  set history=50        " Keep 50 lines of command line history
  set laststatus=2      " Always show the status line
  set noerrorbells      " No error bells
  set nowrap            " Don't wrap
  set number            " Turn on line numbers
  set ruler             " Show the cursor position all the time
  set scrolloff=2       " Show some context when scrolling
  set showcmd           " Display incomplete commands
  set tags=tags;/       " Search recursively for the tags file
  set visualbell        " Get rid of the annoying beep
  set wildmenu          " Show a menu when I hit tab in command mode

  " Search stuff
  set hlsearch        " Use search highlighting
  set ignorecase      " Search ignoring case
  set incsearch       " Do incremental searching


  " Allow backspacing over everything in insert mode
  set backspace=indent,eol,start

  " Allow the cursor to move past the end of the line in visual block mode
  set virtualedit=block

  " Ending with the double slash includes the full path in the filename
  " of the swap files to avoid conflicts
  set directory=~/.vim/tmp//

  " In many terminal emulators the mouse works just fine, thus enable it
  if has('mouse')
    set mouse=a
  endif

  " Use nicer symbols for listchars
  set listchars=trail:·,tab:▸\ ,eol:¬,extends:…,precedes:…

  " Show ↪ at the beginning of wrapped lines
  set showbreak=↪\ " <= Extra whitespace intentional

  " Set up persistent undo for versions of vim that support it
  if v:version >= 703
    set undodir=~/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=1000
  endif

  " GUI only {{{2
  if has("gui_running")
    " Maximize gvim window.
    set lines=150 columns=230

    set guioptions-=T " Get rid of the toolbar
    set guioptions-=e " Get rid of the GUI tabs
    set guioptions-=r " Get rid of the right scrollbar
    set guioptions-=R " Get rid of the right scrollbar
    set guioptions-=l " Get rid of the left scrollbar
    set guioptions-=L " Get rid of the left scrollbar
    set guioptions-=b " Get rid of the bottom scrollbar

    " If there's a gui and it's not Macvim, assume it's something like gvim
    if has("gui_running") && !has("gui_macvim")
      " Get rid of the menu bar (almost as good as full screen)
      set guioptions-=m
    end

    " No blinking cursor
    set guicursor=a:blinkon0

    set signcolumn=yes " We use the sign column diffs and syntax warnings so turn it on
  endif
  " End GUI only
  " }}}2
" End assorted configuration
" }}}1

" Custom colorscheme overrides {{{1
  let g:disable_color_overrides = 0

  augroup ColorOverrides
    au!
    au ColorScheme * call OverrideColors()
  augroup END

  function! OverrideColors()
    if g:disable_color_overrides != 1
      for color_file in split(glob('~/.vim/colors/custom/*.vim'), '\n')
        exe 'source' color_file
      endfor
    endif
  endfunction
" }}}1

" Customize the tab line {{{1
  " Terminal tab labels {{{2
    function! MyTabLine()
      let tabline = ''
      let highest_tab_num = tabpagenr('$')

      " Loop over all of the current tabs
      for i in range(highest_tab_num)
        " Select the highlighting
        if i + 1 == tabpagenr()
          let tabline .= '%#TabLineSel#'
        else
          let tabline .= '%#Normal#'
        endif

        " Set the tab page number (for mouse clicks)
        let tabline .= '%' . (i + 1) . 'T'

        " The label is made by MyTabLabel()
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} '

        " If this isn't the last tab, put in a separator
        if (i + 1) != highest_tab_num
          let tabline .= '%#Normal#%T|'
        endif
      endfor

      " After the last tab fill with TabLineFill and reset tab page nr
      let tabline .= '%#Normal#%T'

      " Right-align the label to close the current tab page
      if tabpagenr('$') > 1
        let tabline .= '%=%#Normal#%999X ✖ '
      endif

      return tabline
    endfunction

    " Custom tab label
    function! MyTabLabel(n)
      let buflist = tabpagebuflist(a:n)
      let winnr = tabpagewinnr(a:n)

      let bufname = bufname(buflist[winnr - 1])
      if len(bufname) < 1
        return '[No Name]'
      else
        let bufname_parts = split(bufname, '/')

        let bufnum = bufnr(buflist[winnr - 1])
        if getbufvar(bufnum, '&modified')
          return '+ ' . bufname_parts[-1]
        else
          return bufname_parts[-1]
        endif
      endif
    endfunction

    " Set the custom tabline
    " Disabled for now (trying the airline tabline)
    " set tabline=%!MyTabLine()
  " End terminal tab labels
  " }}}2

  " GUI tab label {{{2
  if has("gui_running")
    " Customize tab labels so they show just the file name
    " http://old.nabble.com/tabline-showing-only-the-basename-td20813639.html
    set guitablabel=%{GuiTabLabel()}

    " Set up tab labels with tab number, buffer name, number of windows
    function! GuiTabLabel()
      let label = ''
      let bufnrlist = tabpagebuflist(v:lnum)

      " Add '+' if one of the buffers in the tab page is modified
      for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
          let label = '+'
          break
        endif
      endfor

      " Append the tab number
      let label .= tabpagenr().': '

      " Append the buffer name
      let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
      if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
          let name = '[Quickfix List]'
        else
          let name = '[No Name]'
        endif
      else
        " get only the file name
        let name = fnamemodify(name,":t")
      endif
      let label .= name

      " Append the number of windows in the tab page
      let wincount = tabpagewinnr(v:lnum, '$')
      return label . '  [' . wincount . ']'
    endfunction
  endif
  " End GUI tab label.
  " }}}2
" End customize the tab line
" }}}1


" Folding {{{1
  " Custom fold method adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
  set foldtext=GetFoldText()
  function! GetFoldText() "{{{2
    let foldChar = matchstr(&fillchars, 'fold:\zs.')

    let foldIndent = repeat(' ', indent(v:foldstart))
    let foldExcerpt = GetFoldCodeExcerpt()
    let foldTextStart = strpart(foldIndent . foldExcerpt, 0, (winwidth(0) * 2) / 3) . ' '

    let linesCountText = GetLineFoldLineCountText()
    let foldTextEnd = linesCountText . repeat(foldChar, 8)
    let foldTextLength = strlen(substitute(foldTextStart . foldTextEnd, '.', 'x', 'g')) + &foldcolumn
    return foldTextStart . repeat(foldChar, winwidth(0) - foldTextLength) . foldTextEnd
  endfunction

  " Returns the excerpt of the line that will be displayed as part of the
  " the fold.
  function! GetFoldCodeExcerpt()
    let firstLine = getline(v:foldstart)
    let lastLine = getline(v:foldend)

    " Remove some junk we don't want to show from the first and last lines.
    let lineCleanupPattern = '\v^\s*'
    let firstLineSnippet = substitute(firstLine, lineCleanupPattern, '', 'g')
    let lastLineSnippet = substitute(lastLine, lineCleanupPattern, '', 'g')

    " Check for lines where the method name + parameters list is longer than
    " can be displayed. For these, collapse the parameter list.
    let methodAndParamsPattern = '\v(\w+)\(([^\(]*)\)'
    if len(matchstr(firstLineSnippet, methodAndParamsPattern)) > 60
      let firstLineSnippet = substitute(firstLineSnippet, methodAndParamsPattern, '\1(...)', 'g')
    end

    let collapsedChar = '≓'
    return firstLineSnippet . ' ' . collapsedChar . ' ' . lastLineSnippet
  endfunction

  " Returns the line count that will be displayed on the right side of
  " the fold.
  function! GetLineFoldLineCountText()
    let lines_count = v:foldend - v:foldstart + 1
    return ' ' . printf("%10s", lines_count . ' lines') . ' '
  endfunction

  set foldlevelstart=1 " Start folding at level 1, rather than 0
  set foldmethod=syntax " Use the indent level to create folds
  set foldminlines=3 " Don't fold groups that are smaller than this
  " End custom folding
" }}}1


" Custom mappings {{{1
  let mapleader = ","

  " Don't use Ex mode, use Q for formatting
  noremap Q gq

  " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
  " so that you can undo CTRL-U after inserting a line break.
  inoremap <C-U> <C-G>u<C-U>

  " If there's a gui and it's not Macvim, assume it's something like gvim
  if has("gui_running") && !has("gui_macvim")
    " Set up copy and paste so they work more like other apps
    inoremap <C-V> <ESC>"+gpi
    cnoremap <C-V> <C-R>+
    vnoremap <C-C> "+y

    " Adjust the columns and lines to make the page actually full screen
    nnoremap <leader>full :set columns+=1 lines+=1<CR>
  end

  " NERDTree
  noremap <silent> <leader>n :NERDTreeToggle<CR>
  let NERDTreeHijackNetrw=1

  " Quick buffer stuff
  noremap <leader>bd :bd<CR>
  noremap <leader>bdd :bd!<CR>
  noremap <leader>q :q<CR>

  " Quickly get rid of highlighting
  noremap <leader>nh :noh<CR>

  "Fast editing of .vimrc
  noremap <leader>vimrc :tabedit $MYVIMRC<CR>

  " Move to the next tab right with the right arrow key
  noremap <C-right> :tabn<CR>

  " Move to the next tab left with the left arrow key
  noremap <C-left> :tabp<CR>

  " Allow cursor movements during insert mode
  inoremap <C-h> <C-o>h
  inoremap <C-j> <C-o>j
  inoremap <C-k> <C-o>k
  inoremap <C-l> <C-o>l
  inoremap <C-d> <end>

  " Hitting jj will jump out of insert mode
  inoremap jj <esc>

  " Hitting kk will jump out of insert mode
  inoremap kk <esc>

  " Quick vertical split
  noremap <leader>sv :vsplit<CR>

  " Quick horizontal split
  noremap <leader>sh :split<CR>

  " Quick full screen toggle
  noremap <leader>fs :set invfullscreen<CR>

  " Search for selected text, forwards or backwards. (http://vim.wikia.com/wiki/VimTip171)
  vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

  vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

  " Searches only within the range that has been selected
  " (http://vim.wikia.com/wiki/Search_only_over_a_visual_range)
  function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
      let g:srchstr = g:srchstr.
            \ '\%>'.(line("'<")-1).'l'.
            \ '\%<'.(line("'>")+1).'l'
    else
      let g:srchstr = ''
    endif
  endfunction
  vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
  vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

  " Show the yankring
  noremap <leader>yr :YRShow<cr>

  " Quickly generate some lorem ipsum text
  noremap <leader>lorem :Loremipsum<CR>

  " Quickly turn invisibles on and off
  noremap <silent><leader>li :call <SID>ToggleNonText()<CR>

  " Toggle non text character visibility and highlighting
  " This toggles both listchars and the ~ that shows up for
  " empty lines.
  function! s:ToggleNonText()
    if &list
      set nolist

      " This will force any other NonText characters to be invisible
      hi NonText guifg=bg ctermfg=black
    else
      set list
      hi NonText guifg=#A7A7A7 ctermfg=lightgrey
    endif
  endfunction

  " Format the selected section to wrap at 80 chars
  vnoremap <silent> f80 <esc>:set textwidth=80<CR>gvgq :set textwidth=0<CR>

  " Quickly type console.log
  inoremap ccc console.log

  " Always place a found match at the center of the screen.
  nnoremap n nzzzv
  nnoremap N Nzzzv

  " Don't jump around so much when matching with *
  nnoremap * *<c-o>

  " In terminal mode, use the esc key to switch to normal mode,
  " which lets you move around the terminal window using the usual
  " normal mode keys
  tnoremap <C-Esc> <C-W>N
  set notimeout ttimeout timeoutlen=100

  " Open the fzf file explorer with the space bar
  nmap <Space> :Files<CR>

" End custom mappings
" }}}1


" Autocommands {{{1
  if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    augroup vimrcAutoCommands
      au!

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      " Also don't do it when the mark is in the first line, that is the default
      " position when opening a file.
      autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

      " Resize splits when the window is resized
      autocmd VimResized * exe "normal! \<c-w>="

      " Automatically check if the file has been changed outside vim
      autocmd CursorHold,CursorMoved * checktime

      " Spell checking
      if v:version >= 700
        " Enable spell check for text files
        autocmd BufNewFile,BufRead *.txt,*.wiki,*.mkd,*.markdown setlocal spell spelllang=en
      endif

      " Setup JavaScript folding from vim-javascript-syntax
      " au FileType javascript call JavaScriptFold()
    augroup END
  else
    set autoindent " always set autoindenting on
  endif
" End autocommands
" }}}1


" Custom commands {{{1
  " Creates a visual gutter starting at the column passed in.
  " For example to start a gutter at 80 chars:
  "   :CreateGutter 80
  command! -nargs=1 CreateGutter :exec 'setlocal colorcolumn=' . join(range(<args>, 500), ',')

  " Removes the visual gutter.
  command! RemoveGutter :setlocal colorcolumn=

  " Generates a list of emojis in the current buffer
  function! EmojiList()
    for e in emoji#list()
      call append(line('$'), printf('%s (%s)', emoji#for(e), e))
    endfor
  endfunction

  command! EmojiList call EmojiList()
" End custom commands
" }}}1


" Plugin configuration {{{1
  " Set up the yankring history location
  let g:yankring_history_dir = "~/.vim/tmp/yankring"

  " Override the default yankring cycling keys
  " This prevents a conflict with the ctrlp plugin
  let g:yankring_replace_n_pkey = '<m-p>'
  let g:yankring_replace_n_nkey = '<m-n>'

  " Customize git gutter signs
  let g:gitgutter_sign_added = '⎸'
  let g:gitgutter_sign_modified = '⎸'
  let g:gitgutter_sign_removed = '⎸'
  let g:gitgutter_sign_removed_first_line = '⎸'
  let g:gitgutter_sign_modified_removed = '⎸'

  let g:gitgutter_highlight_lines = 1

  " Customize CtrlP

  " Run ctrlp in mixed mode by default
  let g:ctrlp_cmd = 'CtrlPMixed'

  " Don't clear the ctrlp cache on exit
  let g:ctrlp_clear_cache_on_exit = 0

  " Don't limit the number of files to look for
  let g:ctrlp_max_files = 0

  " Add a custom highlight group for the NarrowRegion plugin
  let g:nrrw_rgn_hl = 'NarrowRegion'

  " Add mappings for the configure the dragvisuals plugin
  vmap  <expr>  <LEFT>   DVB_Drag('left')
  vmap  <expr>  <RIGHT>  DVB_Drag('right')
  vmap  <expr>  <DOWN>   DVB_Drag('down')
  vmap  <expr>  <UP>     DVB_Drag('up')
  vmap  <expr>  D        DVB_Duplicate()

  " Customize Ale

  " Open a quickfix window for Ale errors
  let g:ale_open_list = 1

  " Set Ale signs
  let g:ale_sign_error = "✸"
  let g:ale_sign_warning = "✸"

  " Enable the Ale airline plugin
  let g:airline#extensions#ale#enabled = 1

  " Set the height of the Ale window to be only 4 lines tall
  let g:ale_list_window_size = 4

  " Only run Ale when the file has been saved
  let g:ale_lint_on_text_changed = 'never'

  " Customize bufExplorer

  " Show [No Name] buffers, to make them easier to delete.
  let g:bufExplorerShowNoName = 1

  " Customize airline

  if has("gui_running")
    " Show rounded separators
    " See supported separators here: https://github.com/ryanoasis/powerline-extra-symbols
    let g:airline_left_sep = "\uE0B4"
    let g:airline_right_sep = "\uE0B6"
  else
    let g:airline_left_sep = ""
    let g:airline_right_sep = ""
  endif

  " Customize the tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'

  if has("gui_running")
    let g:airline#extensions#tabline#left_sep = "\uE0B0"
    let g:airline#extensions#tabline#left_alt_sep = "\uE0B2"
  endif

  let g:airline#extensions#tabline#buffer_idx_mode = 0
  let g:airline#extensions#tabline#buffer_nr_show = 0
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#tab_min_count = 0

  " Show the branch name, but not the number of changes
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#hunks#enabled = 0

  " Enable trailing whitespace warnings
  let g:airline#extensions#whitespace#enabled = 1
  let g:airline#extensions#whitespace#symbol = ''
  let g:airline#extensions#whitespace#trailing_format = '⎵  [%s]'
  let g:airline#extensions#whitespace#mixed_indent_format = '▸ [%s]'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_symbols.branch = "\uE725"

  let g:airline_theme = 'base16_twilight'

  " Configure JavaScript syntax highlighting
  let g:jsx_ext_required = 0
  au BufNewFile,BufRead *.js6 set filetype=javascript

  " Configure dev-icons
  let g:DevIconsEnableFolderExtensionPatternMatching = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1

  " Configure YouCompleteMe

  " Automatically close the little preview window that pops up for documentation
  let g:ycm_autoclose_preview_window_after_completion = 1

  " Use YouCompleteMe, even inside comments
  let g:ycm_complete_in_comments = 1

  " Look inside strings and comments for identifiers as well
  let g:ycm_collect_identifiers_from_comments_and_strings = 1

  " Seed the identifier database with the keywords for the current language
  let g:ycm_seed_identifiers_with_syntax = 1

  " Pull identifiers from tags files
  let g:ycm_collect_identifiers_from_tags_files = 1

  " MatchTagAlways settings
  let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'eruby' : 1,
    \ 'javascript' : 1
  \}

  " Livedown (markdown preview) binding
  nmap <leader>lm :LivedownToggle<CR>

  " Open the Livedown window automatically
  let g:livedown_open = 1

  " CtrlSF configuration
  let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
  \}

  " Set the highlight duration for the highlighted yank plugin
  let g:highlightedyank_highlight_duration = 3000

  " Automatically run the colorizer plugin for certain filetypes
  let g:colorizer_auto_filetype='css,html,scss'

" End plugin configuration
" }}}1

" Word Processor configuration {{{1
  function! s:goyo_enter()
    " Turn off the automatic custom color overrides group before setting the
    " colorscheme
    let g:disable_color_overrides = 1

    " Customize the pencil colorscheme
    let g:pencil_higher_contrast_ui = 0
    let g:pencil_neutral_code_bg = 0
    let g:pencil_spell_undercurl = 1

    set background=dark
    colorscheme pencil

    " A few colorscheme overrides
    set guifont=\Inconsolata\ for\ Powerline\ Nerd\ Font\ \Complete\ Mono:h23
    hi NonText   guifg=bg guibg=bg
    hi VertSplit guifg=bg guibg=bg gui=none

    " Don't show the break character
    set showbreak=

    " Enable Pencil
    call pencil#init()

    " replace common punctuation
    iabbrev <buffer> -- –
    iabbrev <buffer> --- —
    iabbrev <buffer> << «
    iabbrev <buffer> >> »

    " open most folds
    setlocal foldlevel=6
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
" End word processor configuration
" }}}1
