" Maintainer: Matt Ephraim

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "efrum"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorColumn guibg=#2d2d2d
  hi CursorLine   guibg=#263133
  hi MatchParen   guifg=#F11818 guibg=bg
  hi Pmenu        guifg=#f6f3e8 guibg=#242829
  hi PmenuSel     guifg=#000000 guibg=#cae682
endif

" General colors
hi ColorColumn  guibg=#130707
hi Conceal      guibg=#272727 guifg=#E1F3FA gui=none
hi Cursor       guifg=NONE    guibg=#656565 gui=none
hi Directory    guifg=#8ac6f2
hi FoldColumn   guifg=#444444 guibg=#080808
hi Folded       guibg=#272727 guifg=#E1F3FA gui=none
hi LineNr       guifg=#857b6f guibg=#000000 gui=none
hi NonText      guifg=#A7A7A7 guibg=#090909 gui=none
hi Normal       guifg=#f6f3e8 guibg=#0A0A0A gui=none
hi Search       guibg=#E4F565 guifg=#000000
hi SignColumn   guibg=#0A0A0A
hi SpecialKey   guifg=#808080 guibg=#0A0A0A gui=none
hi TabLineSel   guifg=#D4EB9C
hi Title        guifg=#f6f3e8 guibg=NONE    gui=bold
hi VertSplit    guifg=#181B22 guibg=#181B22 gui=none
hi Visual       guifg=#f6f3e8 guibg=#1F4457 gui=none
hi WildMenu     guifg=#E04331 guibg=#181B22

" Syntax highlighting
hi Boolean      guifg=#E04331 gui=underline
hi Comment      guifg=#A7A7A7
hi Constant     guifg=#E04331 gui=none
hi Error        guifg=#e7f6da guibg=#3A0505
hi Function     guifg=#cae682 gui=none
hi Identifier   guifg=#cae682 gui=none
hi Keyword      guifg=#8ac6f2 gui=none
hi Number       guifg=#F5773C gui=none
hi PreProc      guifg=#81BDCC gui=none
hi Special      guifg=#e7f6da gui=none
hi Statement    guifg=#8ac6f2 gui=none
hi String       guifg=#95e454
hi Tag          gui=underline
hi Todo         guibg=bg guifg=#F1F13A gui=underline
hi Type         guifg=#D4EB9C gui=none
hi Warning      guifg=#e7f6da guibg=#3A0505
hi WarningMsg   guifg=#F11818 guibg=bg

if has("gui_running")
  if has("gui_macvim")
    set guifont=Inconsolata:h16
  else
    set guifont=Inconsolata\ Medium\ 15
  endif
endif

" Status Line
hi StatusLine         guifg=#95e454 guibg=#181B22 gui=none
hi StatusLineNC       guifg=#181B22 guibg=#181B22
hi StatusLineFile     guibg=#181B22
hi StatusLineFileType guifg=#8ac6f2 guibg=bg
hi StatusLineGit      guifg=#D4EB9C guibg=bg

" Diff highlighting
hi DiffAdd    guibg=#D1FFB6 guifg=#080C06
hi DiffChange guibg=#0F1308 guifg=NONE
hi DiffDelete guibg=#290700 guifg=#FC5B3B
hi DiffText   guibg=#D1FFB6 guifg=#080C06

" Syntastic
hi SyntasticError   guibg=bg guifg=#F11818
hi SyntasticWarning guibg=bg guifg=#F1F13A

" Taglist
hi MyTagListFileName guibg=bg guifg=#8ac6f2

" Mediawiki
hi wikiBold	         guifg=#E04331
hi wikiBoldAndItalic guifg=#8ac6f2 gui=none
hi wikiItalic	       guifg=#A7A7A7

hi wikiH1 guifg=#8ac6f2 gui=underline
hi wikiH2 guifg=#8ac6f2 gui=underline
hi wikiH3 guifg=#8ac6f2 gui=underline
hi wikiH4 guifg=#8ac6f2 gui=underline
hi wikiH5 guifg=#8ac6f2 gui=underline
hi wikiH6 guifg=#8ac6f2 gui=underline

hi wikiLink guifg=#95e454 gui=underline

" HTML
hi htmlBold guifg=#E04331
hi htmlUnderline gui=underline
