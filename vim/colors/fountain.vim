set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "twilight"

let s:grey_blue = '#8a9597'
let s:light_grey_blue = '#a0a8b0'
let s:dark_grey_blue = '#34383c'
let s:mid_grey_blue = '#64686c'
let s:beige = '#ceb67f'
let s:light_orange = '#ebc471'
let s:yellow = '#e3d796'
let s:violet = '#a999ac'
let s:green = '#a2a96f'
let s:lightgreen = '#c2c98f'
let s:red = '#d08356'
let s:cyan = '#74dad9'
let s:darkgrey = '#0A0A0A'
let s:grey = '#303030'
let s:lightgrey = '#605958'
let s:white = '#fffedc'

" Basics
hi CursorLine guibg=#262626
hi CursorColumn guibg=#262626
hi MatchParen guifg=white guibg=#80a090 gui=bold

hi TabLine guifg=#a09998 guibg=#202020 gui=underline
hi TabLineFill guifg=#a09998 guibg=#202020 gui=underline
hi TabLineSel guifg=#a09998 guibg=#404850 gui=underline

hi Pmenu guifg=#605958 guibg=#303030 gui=underline
hi PmenuSel guifg=#a09998 guibg=#404040 gui=underline

hi Visual guibg=#404040

execute 'hi Cursor guibg=' . s:green

function! s:highlight(group, fg, bg, gui)
  execute 'hi ' . a:group . ' guifg=' . a:fg . ' guibg='. a:bg . ' gui=' . a:gui
endfunction

call s:highlight('Normal', s:grey_blue, s:darkgrey, 'none')
call s:highlight('Comment', s:mid_grey_blue, s:darkgrey, 'italic')

call s:highlight('fountainBold', s:white, s:darkgrey, 'bold')
call s:highlight('fountainBoldItalic', s:white, s:darkgrey, 'italic,bold')
call s:highlight('fountainItalic', s:white, s:darkgrey, 'italic')
call s:highlight('fountainUnderlined', s:white, s:darkgrey, 'underline')

call s:highlight('fountainBoneyard', s:lightgrey, s:grey, 'italic')
call s:highlight('fountainCentered', s:light_orange, s:darkgrey, 'none')
call s:highlight('fountainCharacter', s:lightgreen, s:darkgrey, 'none')
call s:highlight('fountainDialogue', s:white, s:darkgrey, 'none')
call s:highlight('fountainHeader', s:light_orange, s:darkgrey, 'underline')
call s:highlight('fountainPagebreak', s:red, s:darkgrey, 'bold,underline')
call s:highlight('fountainParenthetical', s:violet, s:darkgrey, 'none')
call s:highlight('fountainSection', s:lightgreen, s:darkgrey, 'bold')
call s:highlight('fountainSceneNumber', s:red, s:darkgrey, 'bold')
call s:highlight('fountainSynopses', s:lightgreen, s:darkgrey, 'italic')
call s:highlight('fountainTitle', s:red, s:darkgrey, 'underline')
call s:highlight('fountainTransition', s:white, s:darkgrey, 'italic,bold')
