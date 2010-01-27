" Maintainer:   Lars H. Nielsen (dengmao@gmail.com)
" Last Change By Lars:  January 22 2007
" Further Changed By: Matt Ephraim

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine   guibg=#2d2d2d
  hi CursorColumn guibg=#2d2d2d
  hi MatchParen   guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu        guifg=#f6f3e8 guibg=#242829
  hi PmenuSel     guifg=#000000 guibg=#cae682
endif

" General colors
hi Cursor       guifg=NONE    guibg=#656565 gui=none
hi Normal       guifg=#f6f3e8 guibg=#070707 gui=none
hi NonText      guifg=#808080 guibg=#090909 gui=none
hi LineNr       guifg=#857b6f guibg=#000000 gui=none
hi StatusLine   guifg=#f6f3e8 guibg=#0B1D27 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#181B22 gui=none
hi VertSplit    guifg=#0B1D27 guibg=#0B1D27 gui=none
hi Folded       guibg=#1B1B1B guifg=#E1F3FA gui=none
hi FoldColumn   guifg=#444444 guibg=#080808
hi Title        guifg=#f6f3e8 guibg=NONE    gui=bold
hi Visual       guifg=#f6f3e8 guibg=#060E12 gui=none
hi SpecialKey   guifg=#808080 guibg=#070707 gui=none

" Syntax highlighting
hi Comment      guifg=#A7A7A7 gui=italic
hi Todo         guibg=#070707 guifg=#F1F13A gui=underline
hi Constant     guifg=#e5786d gui=none
hi String       guifg=#95e454 gui=italic
hi Identifier   guifg=#cae682 gui=none
hi Function     guifg=#cae682 gui=none
hi Type         guifg=#cae682 gui=none
hi Statement    guifg=#8ac6f2 gui=none
hi Keyword      guifg=#8ac6f2 gui=none
hi PreProc      guifg=#e5786d gui=none
hi Number       guifg=#e5786d gui=none
hi Special      guifg=#e7f6da gui=none
hi Error        guifg=#e7f6da guibg=#3A0505
hi Tag          gui=underline

if has("gui_running")
  set guifont=Monaco:h13 
endif 

" Diff highlighting
hi DiffAdd    guibg=#495C44 guifg=#F3F7F3 
hi DiffChange guibg=#49615C guifg=#FAFFFE 
hi DiffText   guifg=#97B191 guibg=#242424 
hi DiffDelete guibg=#290700 guifg=#FC5B3B
