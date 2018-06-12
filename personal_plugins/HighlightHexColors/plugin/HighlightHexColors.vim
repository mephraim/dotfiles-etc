command! HighlightHexColors call s:HighlightHexColors()

let s:HEX_COLOR_PATTERN = "#[0-9A-Fa-f]*"

" Hightlight all of the hex color values in a file
function! s:HighlightHexColors()
  let startPos = getpos('.')
  normal! gg0

  while search(s:HEX_COLOR_PATTERN, "Wc") > 0 
    call s:HighlightHexColorsForLine(line("."))

    if line(".") == line("$")
      break
    endif

    normal! j0
  endwhile

  call setpos(".", startPos)
endfunction

" Highlight all of the syntax colors on a line
function! s:HighlightHexColorsForLine(lineNum)
  let hexColor = matchstr(getline(a:lineNum), s:HEX_COLOR_PATTERN)
  let matchLen = strlen(hexColor)

  if matchLen == 4 || matchLen == 7
    call s:HighlightHex(hexColor)
  endif
endfunction

" Create syntax highlighting for a hex color value
function! s:HighlightHex(hexColor)
  let colorNumbers = substitute(a:hexColor, "#", "", "")
  let highlightName =  "_cssHighlight" . colorNumbers

  " vim doesn't like shorthand hex values, so expand any
  " shorthand values
  if strlen(colorNumbers) == 3
    let part1 = strpart(colorNumbers, 0, 1)
    let part2 = strpart(colorNumbers, 1, 1)
    let part3 = strpart(colorNumbers, 2, 1)

    let bgColor = "#" . part1 . part1 . part2 . part2 . part3 . part3
  else
    let bgColor = a:hexColor
  endif

  " try to choose a foreground color that will match well with the background
  if strlen(matchstr(bgColor, "#\\d"))  > 0
    let fgColor = "#FFFFFF"
  else
    let fgColor = "#000000"
  endif

  " match and highlight a particular hex color value
  exe "syn match " . highlightName . " /" . a:hexColor . "/"
  exe "hi " . highlightName . " guibg=" . bgColor . " guifg=" . fgColor
endfunction
