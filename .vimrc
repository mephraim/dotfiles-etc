" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" Pathogen setup {{{1
  " Make sure pathogen ftplugins are properly installed by disabling then
  " re-enabling file type plugins.
  filetype off

  " Enable auto-loading of per-directory plugins in ~/.vim/bundle
  call pathogen#infect()

  " Do the same for machine local viles in ~/.vim_local/bundle
  call pathogen#infect('~/.vim_local/bundle')

  " Generate helptags for all of the above plugins
  call pathogen#helptags()
" End pathogen setup
" }}}1


" Syntax and colorscheme {{{1
  " Switch syntax highlighting on when the terminal has colors
  " or when a GUI is running.
  if &t_Co > 2 || has("gui_running")
    syntax on
  endif

  if has("gui_running")
    colorscheme efrum
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
  set foldmethod=syntax " Use the syntax file to create folds
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
    else
      " Turn of the annoying beeping when hitting escape in Macvim
      set visualbell
    end

    " No blinking cursor
    set guicursor=a:blinkon0
  endif
  " End GUI only
  " }}}2
" End assorted configuration
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
    set tabline=%!MyTabLine()
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


" Custom folding {{{1
  " A nicer foldtext function via:
  " http://vim.wikia.com/wiki/Customize_text_for_closed_folds
  set foldtext=MyFoldText()
  function! MyFoldText()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
      let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
      let linenum = v:foldstart + 1
      while linenum < v:foldend
        let line = getline( linenum )
        let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
        if comment_content != ''
          break
        endif
        let linenum = linenum + 1
      endwhile
      let sub = initial . ' ' . comment_content
    else
      let sub = line
      let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
      if startbrace == '{'
        let line = getline(v:foldend)
        let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
        if endbrace == '}'
          let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
        endif
      endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
  endfunction
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

      if has("gui_running")
        " Highlight trailing whitespace
        autocmd BufRead * match Warning /\s\+\%#\@<!$/
        autocmd BufRead * match Warning /\s\+$/
      endif
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
" End custom commands
" }}}1


" Plugin configuration {{{1
  " Set up the yankring history location
  let g:yankring_history_dir = "~/.vim/tmp/yankring"

  " Override the default yankring cycling keys
  " This prevents a conflict with the ctrlp plugin
  let g:yankring_replace_n_pkey = '<m-p>'
  let g:yankring_replace_n_nkey = '<m-n>'

  " Tell the lusty plugins to be quiet about not having Ruby support in the
  " terminal
  let g:LustyJugglerSuppressRubyWarning = 1

  " Customize the signify signs
  let g:signify_sign_add               = '⎸'
  let g:signify_sign_change            = '⎸'
  let g:signify_sign_delete            = '⎸'
  let g:signify_sign_delete_first_line = '⎸'

  " Tell signify to only look for git changes
  let g:signify_vcs_list = ['git']

  " Tell signify to always highlight changed lines
  let g:signify_line_highlight = 1

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

  " Customize syntastic
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_enable_signs = 0

  " Customize airline

  " The default theme doesn't look very good in the terminal.
  if !has("gui_running")
    let g:airline_theme="simple"
  endif

  " Don't show any separators
  let g:airline_left_sep=''
  let g:airline_right_sep=''

  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#hunks#enabled = 0

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#tab_min_count = 2

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_symbols.branch = '⎇ '

" End plugin configuration
" }}}1
