if exists("b:current_syntax")
  finish
endif
syn sync minlines=200

syntax match fountainSection1 "^\s*# \(\_[^#]\)" fold transparent contains=ALL
syntax region fountainTitlePage start="\%^\(.*\):" end="^$" contains=fountainBoneyard,fountainNotes
syntax match fountainCharacter "^\(\L\)*$" 
syntax region fountainDialogue matchgroup=fountainCharacter start="^\(\L\)*$" end="^\s*$" contains=fountainCharacter,fountainParenthetical,fountainBoneyard,fountainNotes,fountainEmphasis,fountainUnderlined,fountainItalic,fountainBold,fountainBoldItalic
syntax match fountainParenthetical "^\s*\((.*)\)$" contained contains=fountainBoneyard,fountainNotes
syntax match fountainTransition "^\(\L\)* TO:$" contains=fountainBoneyard,fountainNotes
syntax match fountainTransitionForced "^\s*>\(.*\)" contains=fountainBoneyard,fountainNotes
syntax match fountainCentered "^\s*>\(.*\)<" contains=fountainBoneyard,fountainNotes

syntax region fountainUnderlined concealends matchgroup=fountain start=/\v_/ end=/\v_/ contains=ALL
syntax region fountainItalic concealends matchgroup=fountain start="\*" end="\*" contains=ALL
syntax region fountainBold concealends matchgroup=fountain start="\*\*" end="\*\*" contains=ALL
syntax region fountainBoldItalic concealends matchgroup=fountain start="\*\*\*" end="\*\*\*" contains=ALL

syntax match fountainPagebreak "^===[=]*$"
syntax region fountainNotes start="\[\[" end="\]\]" contains=xLineContinue

syntax region fountainHeader1 concealends matchgroup=fountain start="^\s*# " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainHeader2 concealends matchgroup=fountain start="^\s*## " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainHeader3 concealends matchgroup=fountain start="^\s*### " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainHeader4 concealends matchgroup=fountain start="^\s*#### " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainHeader5 concealends matchgroup=fountain start="^\s*##### " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainHeader6 concealends matchgroup=fountain start="^\s*###### " end="$" contains=fountainBoneyard,fountainNotes

syntax region fountainSynopses concealends matchgroup=fountain start="^\s*= " end="$" contains=fountainBoneyard,fountainNotes
syntax region fountainSceneHeading start="^\s*\(\.\|INT\. \|EXT\. \|INT\./EXT\. \|INT/EXT\. \|INT \|EXT \|INT/EXT \|I/E \|int\. \|ext\. \|int\./ext\. \|int/ext\. \|int \|ext \|int/ext \|i/e \)" end="$" contains=fountainSceneNumber,fountainBoneyard,fountainNotes 
syntax region fountainBoneyard concealends matchgroup=fountain start="/\*" end="\*\/" contains=xLineContinue
syntax match xLineContinue "\\$" contained
syntax region fountainSceneNumber concealends matchgroup=fountain start="#" end="#" contained

hi def link fountainActionForced normal
hi def link fountainNotes	comment
hi def link fountainSceneHeading fountainTitle
hi def link fountainTitlePage	fountainTitle
hi def link fountainTransitionForced	fountainTransition

hi def link fountainHeadek1 fountainHeader
hi def link fountainHeader2 fountainHeader
hi def link fountainHeader3 fountainHeader
hi def link fountainHeader4 fountainHeader
hi def link fountainHeader5 fountainHeader
hi def link fountainHeader6 fountainHeader

let b:current_syntax = "fountain"
