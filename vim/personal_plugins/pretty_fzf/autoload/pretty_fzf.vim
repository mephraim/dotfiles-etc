" The "fancy" version requires neovim, ripgrep and bat, so make sure those
" are installed first.
function! pretty_fzf#OpenFiles()
  if g:fancy_fzf_enable_dev_icons
    call pretty_fzf#OpenFzfWithDevIcons()
  else
    :Files
  end
endfunction

" Create a floating FZF window
function! pretty_fzf#FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 20

  " For smaller screens, use a wider floating window
  if &columns < 150
    let width = float2nr(&columns * 0.9)
  else
    let width = float2nr(&columns * 0.7)
  end

  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 8,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction 

" Open the fzf list of files, but add some extra fanciness under the
" right conditions.
"
" Bring up a version of the FZF file browser that has devicons and a
" preview window added (requires that the `bat` binary is installed).
"
" Inspired by this thread:
" https://github.com/ryanoasis/vim-devicons/issues/106
function! pretty_fzf#OpenFzfWithDevIcons()
  function! s:fzf_dev_icons_files()
    let l:fzf_command = "rg --hidden --glob '!.git/*' -l \"\""
    let l:files = split(system(l:fzf_command), '\n')

    return s:fzf_dev_icons_prepend_icon(l:files)
  endfunction

  function! s:fzf_dev_icons_prepend_icon(candidates)
    let result = []

    for candidate in a:candidates
      let filename = fnamemodify(candidate, ':p:t')
      let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
      call add(result, printf('%s %s', icon, candidate))
    endfor

    return result
  endfunction

  function! s:fzf_dev_icons_edit_file(items)
    let items = a:items
    let i = 1
    let ln = len(items)

    while i < ln
      let item = items[i]
      let parts = split(item, ' ')
      let file_path = get(parts, 1, '')
      let items[i] = file_path
      let i += 1
    endwhile

    call s:Sink(items)
  endfunction

  let opts = fzf#wrap({})
  let opts.source = <sid>fzf_dev_icons_files()
  let s:Sink = opts['sink*']
  let opts['sink*'] = function('s:fzf_dev_icons_edit_file')

  call fzf#run(opts)
endfunction
