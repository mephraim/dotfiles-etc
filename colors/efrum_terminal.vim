" Maintainer: Matt Ephraim
" Available 16 colors:
" Black
" DarkBlue
" DarkGreen
" DarkCyan
" DarkRed
" DarkMagenta
" Brown, DarkYellow
" LightGray, LightGrey, Gray, Grey
" DarkGray, DarkGrey
" Blue, LightBlue
" Green, LightGreen
" Cyan, LightCyan
" Red, LightRed
" Magenta, LightMagenta
" Yellow, LightYellow
" White

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "efrum_terminal"

" Vim >= 7.0 specific colors
if version >= 700
  hi MatchParen ctermbg=black ctermbg=darkred
  hi Pmenu      ctermbg=black ctermfg=darkgrey
  hi PmenuSel   ctermbg=darkgreen ctermfg=black
endif

" General colors
hi Directory    ctermfg=white
hi Folded       ctermfg=black ctermbg=gray
hi LineNr       ctermfg=darkgrey
hi NonText      ctermfg=darkgrey
hi Spellbad     cterm=underline ctermfg=black
hi TabLineSel   ctermfg=green
hi Title        ctermfg=green
hi VertSplit    ctermfg=darkgrey ctermbg=darkgrey
hi Visual       ctermfg=black ctermbg=darkgreen
hi WildMenu     ctermfg=black ctermbg=lightgreen

" Status Line
hi StatusLine         ctermfg=black ctermbg=green
hi StatusLineNC       ctermfg=black ctermbg=black
hi StatusLineFile     ctermfg=white
hi StatusLineFileType ctermfg=blue
hi StatusLineGit      ctermfg=green

" Syntax highlighting
hi Boolean      ctermfg=lightred
hi Comment      ctermfg=darkgrey
hi Function     ctermfg=blue
hi Number       ctermfg=lightgreen
hi PreProc      ctermfg=lightgrey
hi Special      ctermfg=lightblue
hi Statement    ctermfg=darkred
hi String       ctermfg=lightgreen
hi Todo         ctermfg=yellow ctermbg=none
hi Type         ctermfg=lightblue

" Diff highlighting
hi diffAdded    ctermfg=green 
hi diffRemoved  ctermfg=darkred
hi diffNewFile  ctermfg=green

" Git commits
hi gitcommitSummary ctermfg=lightblue
hi gitcommitOverFlow ctermbg=darkred ctermfg=white
hi gitcommitSelectedFile ctermfg=lightgreen

" GitStatus
hi GitStatusLine ctermfg=green

" Syntastic
hi SyntasticError   ctermfg=yellow
hi SyntasticWarning ctermfg=red
