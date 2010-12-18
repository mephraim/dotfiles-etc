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
hi LineNr       ctermfg=darkgrey
hi NonText      ctermfg=darkgrey
hi Title        ctermfg=green
hi VertSplit    ctermbg=white
hi Visual       ctermbg=darkgreen ctermfg=black

" Syntax highlighting
hi Boolean      ctermfg=lightred
hi Comment      ctermfg=darkgrey
hi Function     ctermfg=lightblue
hi Number       ctermfg=lightgreen
hi PreProc      ctermfg=lightgrey
hi Special      ctermfg=lightblue
hi Statement    ctermfg=darkred
hi String       ctermfg=lightblue
hi Todo         ctermfg=yellow ctermbg=black
hi Type         ctermfg=lightblue

" Diff highlighting
hi diffAdded    ctermfg=green 
hi diffRemoved  ctermfg=darkred
hi diffNewFile  ctermfg=green

" Git commits
hi gitcommitSummary ctermfg=lightblue
hi gitcommitOverFlow ctermbg=darkred ctermfg=white
hi gitcommitSelectedFile ctermfg=lightgreen

