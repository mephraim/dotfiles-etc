" Custom overrides after the colorsheme has loaded

" Hide NonText characters by default.
" There's function that will make them visible in .vimrc.
hi NonText guifg=bg ctermfg=black

" Warnings
hi Warning    guifg=#e7f6da guibg=#3A0505
hi WarningMsg guifg=#F11818 guibg=bg

" Highlight trailing whitespace
if has("gui_running")
  autocmd BufRead * match Warning /\s\+\%#\@<!$/
  autocmd BufRead * match Warning /\s\+$/
endif

" UI Elements
hi Boolean     guifg=#E04331 gui=underline
hi ColorColumn guibg=#130707
hi Cursor      guifg=bg      guibg=#F5773c gui=none
hi Directory   guifg=#CFCFCF
hi Folded      guibg=bg guifg=#434343 gui=italic
hi FoldColumn  guifg=#444444 guibg=#080808
hi Normal      guibg=#0A0A0A gui=none
hi NonText     guifg=bg guibg=#0A0A0A
hi SignColumn  guibg=#0A0A0A
hi TabLineSel  guifg=#D4EB9C
hi VertSplit   guifg=#181B22 guibg=bg gui=none
hi Visual      guifg=#f6f3e8 guibg=#1F4457 gui=none
hi WildMenu    guifg=#E04331 guibg=bg

" Status Line
hi StatusLine         guifg=#95e454 guibg=bg gui=none
hi StatusLineNC       guifg=bg guibg=bg
hi StatusLineFile     guibg=bg
hi StatusLineFileType guifg=#8ac6f2 guibg=bg
hi StatusLineGit      guifg=#D4EB9C guibg=bg

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorColumn guibg=#2d2d2d
  hi CursorLine   guibg=#263133
  hi MatchParen   guifg=#E04331 guibg=bg
  hi Pmenu        guifg=#f6f3e8 guibg=#242829
  hi PmenuSel     guifg=#000000 guibg=#cae682
endif

" Diff highlighting
hi DiffAdd    guibg=#D1FFB6 guifg=#080C06
hi DiffChange guibg=#0F1308 guifg=NONE
hi DiffDelete guibg=#290700 guifg=#FC5B3B
hi DiffText   guibg=#D1FFB6 guifg=#080C06

" Terminal colors
hi Terminal guibg=#111720 guifg=fg
