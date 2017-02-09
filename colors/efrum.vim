" Maintainer: Matt Ephraim

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "efrum"

" General colors
hi Conceal      guibg=#272727 guifg=#E1F3FA gui=none
hi Normal       guifg=#f6f3e8 guibg=#0A0A0A gui=none
hi Search       guibg=#E4F565 guifg=#000000
hi SpecialKey   guifg=#808080 guibg=#0A0A0A gui=none
hi Title        guifg=#f6f3e8 guibg=NONE    gui=bold

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

" Status Line
hi StatusLine         guifg=#95e454 guibg=bg gui=none
hi StatusLineNC       guifg=bg guibg=bg
hi StatusLineFile     guibg=bg
hi StatusLineFileType guifg=#8ac6f2 guibg=bg
hi StatusLineGit      guifg=#D4EB9C guibg=bg

" HTML
hi htmlBold guifg=#E04331
hi htmlUnderline gui=underline
hi htmlLink gui=none
