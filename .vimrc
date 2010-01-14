colorscheme wombat

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set nowrap 	    " nowrap!
set number          " gotta have my line numbers
set noerrorbells    " no error bells
set visualbell      
set hidden          " allow buffer switching without saving

set expandtab       " set up spaces as tabs
set sts=2           " 2 spaces
set shiftwidth=2
set smarttab

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

" Spell checking
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
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

  set autoindent	" always set autoindenting on

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
  set guioptions-=T         " get rid of the toolbar
  set guicursor=a:blinkon0  " no blinking cursor
  set transparency=3        " a little transparency just for fun
endif 


" Status line """""""""""""""""""""""""""""""""""""

" Syntastic errors
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader stuff """""""""""""""""""""""""""""""""""""
let mapleader = ","

" Ack for the current word
map <leader>aw :Ack <c-r>=expand("<cword>")<CR><CR> 

" Fuzzfinder stuff
map <leader>fb :FufBuffer<CR>
map <leader>ff :FufFile<CR>
map <leader>fd :FufDir<CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" Quick buffer stuff
map <leader>bd :bd<CR>
map <leader>bdd :bd!<CR>

" Quickly get rid of highlighting
map <leader>nh :noh<CR>

" Taglist
map <leader>tl :TlistToggle<CR>

"Fast editing of .vimrc
map <leader>vimrc :e! ~/.vimrc<CR>

" Allow cursor movements during insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
imap <C-d> <end>

" hitting jj will jump out of insert mode
imap jj <esc>

" Quickly add a semicolon to the end of the line (there's probably a much
" better way to do this)
map <silent> <leader>; mZ$A;<C-c>`Z:delmarks Z<CR>

" quick vertical split
map <leader>sv :vsplit<CR>

" quick horizontal split
map <leader>sh :split<CR>

" Quick full screen toggle
map <leader>fs :set invfullscreen<CR>

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

" Rspec stuff """"""""""""""""""""""""""""""""

" Run Rspec for the current spec file
function! RunRspec()
ruby << EOF
  buffer = VIM::Buffer.current
  spec_file = VIM::Buffer.current.name
  command = "ruby ~/.vim/bin/run_rspec.rb #{spec_file}"
  print "Running Rspec for #{spec_file}. Results will be displayed in Firefox."
  system(command)
EOF
endfunction

map !s :call RunRspec()<cr>

""""""""""""""""""""""""""""""""""""""""""""""

" Sets up SCMDiff with git as the source control
let g:SCMDiffCommand = 'git'

" Showmarks config  """"""""""""""""""""""""""""""""

" Turn showmarks off by default
let g:showmarks_enable=0

" Don't show automatic marks
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Error coloring for the JSlint plugin
let g:jslint_highlight_color="#6F2828"  

" Disable jslint for now"
let g:jslint_disabled=1

" For Ruby focused testing """"""""""""""""""""""""""
map <silent> <leader>rb :RunAllRubyTests<CR>
map <silent> <leader>rc :RunRubyFocusedContext<CR>
map <silent> <leader>rf :RunRubyFocusedUnitTest<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show the yankring """"""""""""""""""""""""""""""""" 
map <leader>yr :YRShow<cr>

" Tasklist stuff """"""""""""""""""""""""""""""""""""

" Show the tasklist
map <leader>todo <Plug>TaskList

" Show the tasklist on the bottom
let g:tlWindowPosition = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntastic stuff """""""""""""""""""""""""""""""""""
let g:syntastic_enable_signs=0
let g:syntastic_auto_loc_list=1
