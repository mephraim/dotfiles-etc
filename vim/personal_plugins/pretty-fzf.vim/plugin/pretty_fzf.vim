" Display a prettier version of the fzf plugin using the setup from here: https://www.reddit.com/r/vim/comments/9xpb18/file_preview_with_fzf_rg_bat_and_devicons/

" Setup ripgrep, which is required by the other methods below
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons
function! s:Files()
  let l:fzf_files_options = '--preview "bat --theme="zenburn" --style=numbers,changes --color always {2..-1} | head -'.&lines.'" --expect=ctrl-t,ctrl-v,ctrl-x --multi --bind=ctrl-a:select-all,ctrl-d:deselect-all'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                   \ 'ctrl-v': 'vertical split',
                   \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

command PrettyFzfFiles call s:Files()
