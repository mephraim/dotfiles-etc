" Custom overrides after the colorsheme has loaded

" Hide NonText characters by default.
" There's function that will make them visible in .vimrc.
hi NonText guifg=bg ctermfg=black

hi Conceal guibg=bg

" Warnings and Errors
hi Error      guifg=#F11818 guibg=bg
hi Warning    guifg=#e7f6da guibg=#3A0505
hi WarningMsg guifg=#F11818 guibg=bg

" UI Elements
hi Boolean     guifg=#E04331 gui=underline
hi ColorColumn guibg=#130707
hi Cursor      guifg=bg      guibg=#F5773c gui=NONE
hi Directory   guifg=#CFCFCF ctermfg=lightgray cterm=NONE
hi Folded      ctermfg=59 ctermbg=16 guibg=bg guifg=#434343 gui=italic
hi FoldColumn  guifg=#444444 guibg=#080808
hi LineNr      ctermfg=59 ctermbg=16 guibg=bg guifg=#434343
hi Normal      guibg=#1D1D1D gui=NONE ctermbg=16
hi NonText     ctermfg=bg guifg=bg guibg=NONE
hi SignColumn  guibg=#1D1D1D
hi TabLineSel  guifg=#D4EB9C
hi VertSplit   ctermfg=16 ctermbg=16 guifg=#181B22 guibg=bg gui=NONE
hi Visual      guifg=NONE guibg=#1F4457 gui=none ctermbg=green ctermfg=bg
hi WildMenu    guifg=#E04331 guibg=bg

" Status Line
hi StatusLine         guifg=#95e454 guibg=bg gui=NONE
hi StatusLineNC       guifg=bg guibg=bg
hi StatusLineFile     guibg=bg
hi StatusLineFileType guifg=#8ac6f2 guibg=bg
hi StatusLineGit      guifg=#D4EB9C guibg=bg

hi CursorColumn guibg=#2d2d2d
hi CursorLine   guibg=#131313 ctermbg=black cterm=NONE gui=bold
hi MatchParen   guifg=#E04331 guibg=bg ctermfg=124 ctermbg=16
hi Pmenu        guifg=#f6f3e8 guibg=#242829
hi PmenuSel     guifg=#000000 guibg=#cae682

" Diff highlighting
hi DiffAdd    guibg=#D1FFB6 guifg=#080C06
hi DiffChange guibg=#0F1308 guifg=NONE
hi DiffDelete guibg=#290700 guifg=#290700
hi DiffText   guibg=#D1FFB6 guifg=#080C06

" Terminal colors
hi Terminal guibg=#111720 guifg=fg

" Spelling
hi SpellBad guifg=red gui=undercurl

hi QuickFixLine ctermbg=52

hi TelescopeBorder guifg=#444444
hi FloatBorder guifg=#444444
hi FloatTitle guifg=#CFCFCF guibg=bg

