call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("gui_running")
  colorscheme efrum

  " Highlight trailing whitespace
  au InsertEnter * match Warning /\s\+\%#\@<!$/
  au InsertLeave * match Warning /\s\+$/
else
  let &t_Co=256
  colorscheme efrum_terminal
end

let mapleader = ","

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set nowrap          " nowrap!
set number          " gotta have my line numbers
set noerrorbells    " no error bells
set hidden          " allow buffer switching without saving

set expandtab       " set up spaces as tabs
set tabstop=2
set sts=2           " 2 spaces
set shiftwidth=2
set shiftround      " when at 3 spaces, and I hit > ... go to 4, not 5
set smarttab

set smartindent     " Indent based on the previous line

" Allow the cursor to move past the end of the line in visual block mode
set virtualedit=block

" Show a menu when I hit tab in command mode
set wildmenu

" ending with the double slash includes the full path in the filename
" of the swap files to avoid conflicts
set directory=~/.vim/tmp//

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Search stuff
set hlsearch        " Use search highlighting
set incsearch       " do incremental searching
set ignorecase      " search ignoring case

" Search recursively for the tags file
set tags=tags;/

" Spell checking
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt,*.wiki,*.mkd,*.markdown setlocal spell spelllang=en
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Gui stuff
if has("gui_running")
  set lines=150 columns=230 " Maximize gvim window.

  set guioptions-=T " Get rid of the toolbar
  set guioptions-=e " Get rid of the GUI tabs
  set guioptions-=r " Get rid of the right scrollbar
  set guioptions-=R " Get rid of the right scrollbar
  set guioptions-=l " Get rid of the left scrollbar
  set guioptions-=L " Get rid of the left scrollbar
  set guioptions-=b " Get rid of the bottom scrollbar


  " if there's a gui and it's not Macvim, assume it's something like gvim
  if !has("gui_macvim")
    set guioptions-=m "Get rid of the menu bar (almost as good as full screen)
    " Set up copy and paste so they work more like other apps
    imap <C-V> <ESC>"+gpi
    cmap <C-V> <C-R>+
    vmap <C-C> "+y

    " Adjust the columns and lines to make the page actually full screen
    nmap <leader>full :set columns+=1 lines+=1<CR>
  end

  set guicursor=a:blinkon0  " no blinking cursor

  if has("transparency")
    set transparency=1        " a little transparency just for fun
  endif

  " Customize tab labels so they show just the file name http://old.nabble.com/tabline-showing-only-the-basename-td20813639.html
  set guitablabel=%{GuiTabLabel()}

  " set up tab labels with tab number, buffer name, number of windows
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

" Custom tabline
function! MyTabLine()
  let tabline = ''
  let highest_tab_num = tabpagenr('$')

  " Loop over all of the current tabs
  for i in range(highest_tab_num)
    " select the highlighting
    if i + 1 == tabpagenr()
      let tabline .= '%#TabLineSel#'
    else
      let tabline .= '%#Normal#'
    endif

    " set the tab page number (for mouse clicks)
    let tabline .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} '

    " If this isn't the last tab, put in a separator
    if (i + 1) != highest_tab_num
      let tabline .= '%#Normal#%T|'
    endif
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let tabline .= '%#Normal#%T'

  " right-align the label to close the current tab page
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

" Use the same symbols as TextMate for tabstops and EOLs (thanks vimcasts.org)
set listchars=trail:·,tab:▸\ ,eol:¬,extends:…,precedes:…

" Show ↪ at the beginning of wrapped lines.
let &sbr = nr2char(8618).' '

" Show some context when scrolling
set scrolloff=2

" Status line """""""""""""""""""""""""""""""""""""
set laststatus=2  " Always show the status line
set statusline=%!SetStatusLine()

let g:showFullPathInStatusLine = 0

function! SetStatusLine()
  set statusline=\ ●\                     " Show an indicator for the current window
  set statusline+=%#Warning#%m            " Show if the file has been modified

  if g:showFullPathInStatusLine
    set statusline+=%#StatusLineFile#[%f]   " Show the full path to the file
  else
    set statusline+=%#StatusLineFile#[%t]   " Just show the file name
  endif

  set statusline+=%#StatusLineFileType#%y " Then show the file type

  " Fugitive
  set statusline+=%#StatusLineGit#
  set statusline+=%{fugitive#statusline()}
  set statusline+=%#StatusLine#

  " Right aligned items
  set statusline+=%=
  set statusline+=%<
  set statusline+=%#Comment#
  set statusline+=[%l,%c]     " Show the current line and column
  set statusline+=[%p%%]      " Show the current % through the file
  set statusline+=[%L\ lines] " Show the number of lines

  set statusline+=%#*#
endfunction!

function! ToggleFullPathInStatusLine()
  let g:showFullPathInStatusLine = !g:showFullPathInStatusLine
  call SetStatusLine()
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""

" Set up persistent undo for versions of vim that support it
if v:version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000
  set undoreload=1000
endif

" Mappings """""""""""""""""""""""""""""""""""""

" Toggle the full path showing in the status line
map <silent> <leader>fp :call ToggleFullPathInStatusLine()<CR>

" Ack for the current word
map <leader>aw :Ack <c-r>=expand("<cword>")<CR><CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" Quick buffer stuff
map <leader>bd :bd<CR>
map <leader>bdd :bd!<CR>
map <leader>q :q<CR>

" Quickly get rid of highlighting
map <leader>nh :noh<CR>

" Taglist
map <leader>tl :TlistToggle<CR>

"Fast editing of .vimrc
map <leader>vimrc :tabedit $MYVIMRC<CR>

" Quickly create a new tab
map <A-t> :tabnew<CR>

" Move to the next tab right with the right arrow key
map <C-right> :tabn<CR>

" Move to the next tab left with the left arrow key
map <C-left> :tabp<CR>

" Allow cursor movements during insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
imap <C-d> <end>

" hitting jj will jump out of insert mode
imap jj <esc>

" hitting kk will jump out of insert mode
imap kk <esc>

" Quickly add a semicolon to the end of the line (there's probably a much
" better way to do this)
map <silent> <leader>; mZ$A;<C-c>`Z:delmarks Z<CR>

" quick vertical split
map <leader>sv :vsplit<CR>

" quick horizontal split
map <leader>sh :split<CR>

" Quick full screen toggle
map <leader>fs :set invfullscreen<CR>

" For Ruby focused testing """"""""""""""""""""""""""
map <silent> <leader>rb :RunAllRubyTests<CR>
map <silent> <leader>rc :RunRubyFocusedContext<CR>
map <silent> <leader>rf :RunRubyFocusedUnitTest<CR>
map <silent> <leader>rl :RunLastRubyTest<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show the yankring """""""""""""""""""""""""""""""""
map <leader>yr :YRShow<cr>

" Quickly generate some lorem ipsum text
map <leader>lorem :Loremipsum<CR>

" Quickly turn wrapping on and off
map <leader>wr :set wrap!<CR>

" Quickly turn invisibles on and off
map <leader>li :set list!<CR>

" Encode HTML entities
map <leader>enc :HTMLSpecialChars<CR>

" Unencode HTML entities
map <leader>uenc :HTMLSpecialCharsDecode<CR>

" Turn expandtab on and off
map <silent> <leader>tabon :set expandtab!<CR>
map <silent> <leader>taboff :set expandtab<CR>

" Create a ConqueTerm buffer shell  
map <silent> <leader>cts :ConqueTerm bash<CR>
"
" Create a horizontal split screen with a ConqueTerm buffer shell
map <silent> <leader>ctsh :ConqueTermSplit bash<CR>

" Create a vertical split screen with a ConqueTerm buffer shell
map <silent> <leader>ctsv :ConqueTermVSplit bash<CR>

" Open the command + T browser window
map <silent> <leader>ct :CommandT<CR>

" Remove trailing whitespace
map <leader>rmtws :%s/\s\+$//<cr>:let @/=''<CR>

" Maps the combination of w and % to expand the out to the current word
cmap w% <c-r>=expand("<cword>")<CR>

" Pulse the cursorline when navigation search matches
nnoremap n n:call PulseCursorLine#Pulse()<CR>
nnoremap N N:call PulseCursorLine#Pulse()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Folding stuff """""""""""""""""""""""""""""" 
set foldmethod=syntax " use the syntax file to create folds

" Set a nicer foldtext function via http://vim.wikia.com/wiki/Customize_text_for_closed_folds
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
""""""""""""""""""""""""""""""""""""""""""""""

" Error coloring for the JSlint plugin
let g:jslint_highlight_color="#6F2828"  

" Disable jslint for now"
let g:jslint_disabled=1

" Set up the yankring history location
let g:yankring_history_dir = "~/.vim/tmp/yankring"

" Tell the lusty plugins to be quiet about not having Ruby support in the
" terminal
let g:LustyJugglerSuppressRubyWarning = 1

" Continue ConqueTerm shell when it's not the current, focused buffer
let g:ConqueTerm_ReadUnfocused = 1

" Setup indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Turn off the pyflakes quickfix list
let g:pyflakes_use_quickfix = 0



