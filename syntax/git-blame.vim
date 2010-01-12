if exists("b:current_syntax")
    finish
endif

syn match gitblameNotCommitted /.*Not Committed Yet.*/ contained 
syn match gitblameSHA1 /^[0-9a-f]\+/ contained
syn match gitblameHistory /^[0-9a-f]\+ ([^)]*)/ contains=gitblameSHA1,gitblameNotCommitted

hi link gitblameSHA1 Statement
hi link gitblameHistory Comment
hi link gitblameNotCommitted DiffAdd

let b:current_syntax = "gitblame"
