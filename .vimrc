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
set cursorline      " highlight the current line

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

" Allow cursor movements during insert mode
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
imap <C-d> <end>

""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets up SCMDiff with git as the source control
let g:SCMDiffCommand = 'git'

" Showmarks config  """"""""""""""""""""""""""""""""

" Turn showmarks off by default
let g:showmarks_enable=0

" Don't show automatic marks
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"""""""""""""""""""""""""""""""""""""""""""""""""""""
