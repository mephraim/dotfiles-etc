" Maintainer: Matt Ephraim

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "efrum_terminal"

" Vim >= 7.0 specific colors
if version >= 700
  hi MatchParen ctermbg=black ctermbg=darkred
  hi Pmenu      ctermbg=darkgray ctermfg=white
  hi PmenuSel   ctermbg=darkgreen ctermfg=black
endif

" General colors
hi Directory    ctermfg=white
hi Folded       ctermfg=black ctermbg=gray
hi LineNr       ctermfg=darkgrey
hi NonText      ctermfg=darkgrey
hi TabLineSel   ctermfg=green
hi Title        ctermfg=green
hi VertSplit    ctermfg=white ctermbg=white 
hi Visual       ctermfg=darkgreen ctermbg=black
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
hi Function     ctermfg=lightblue
hi Number       ctermfg=lightgreen
hi PreProc      ctermfg=lightgrey
hi Special      ctermfg=lightblue
hi Statement    ctermfg=darkred
hi String       ctermfg=lightblue
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
