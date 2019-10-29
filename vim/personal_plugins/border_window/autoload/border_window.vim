function! border_window#Open(options)
  let width = a:options.width
  let height = a:options.height

  if a:options.center
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
  else
    let top = a:options.top
    let left = a:options.left
  endif

  let background = s:open_background_window(top - 1, left - 2, width + 4, height + 2)
  let main = s:open_main_window(top, left, width, height, background.buffer)

  return { 'main': main, 'background': background }
endfunction

function! s:open_background_window(top, left, width, height)
  let opts = {
  \ 'width': a:width,
  \ 'height': a:height,
  \ 'relative': 'editor',
  \ 'row': a:top,
  \ 'col': a:left,
  \ 'focusable': v:false,
  \ 'style': 'minimal'
  \ }

  let top = '╭' . repeat('─', a:width - 2) . '╮'
  let mid = '│' . repeat(' ', a:width - 2) . '│'
  let bot = '╰' . repeat('─', a:width - 2) . '╯'

  let lines = [top] + repeat([mid], a:height - 2) + [bot]
  let buffer = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(buffer, 0, -1, v:true, lines)

  let window = nvim_open_win(buffer, v:true, opts)
  set winhl=Normal:Normal

  return { 'buffer': buffer, 'window': window, 'opts': opts }
endfunction

function! s:open_main_window(top, left, width, height, background_buffer)
  let opts = {
  \ 'focusable': v:true,
  \ 'relative': 'editor',
  \ 'row': a:top,
  \ 'col': a:left,
  \ 'width': a:width,
  \ 'height': a:height,
  \ 'style': 'minimal'
  \ }

  let buffer = nvim_create_buf(v:false, v:true)
  let window = nvim_open_win(buffer, v:true, opts)

  " Dynamically create autocmds that will close the background buffer when
  " the main buffer closes.
  "
  " The autocmds need to be created dynamically, because they won't have access
  " to the function variables when they actually execute
  let autocmd_content = '<buffer=' . buffer . '> exe "bw ' . a:background_buffer . '"'
  execute('autocmd BufHidden ' . autocmd_content)

  return { 'buffer': buffer, 'window': window, 'opts': opts }
endfunction

function! border_window#test()
  let options = {
  \ 'center': v:false,
  \ 'height': 5,
  \ 'width': 20,
  \ 'top': 5,
  \ 'left': 5
  \ }

  let window = border_window#Open(options)
  call border_window#Fade(window)
endfunction

function! border_window#Fade(window)
  function! s:Fade(window)
    let winblend = nvim_win_get_option(a:window.main.window, 'winblend')
    call nvim_win_set_option(a:window.main.window, 'winblend', winblend + 1)
  endfunction

  call timer_start(50, { timer -> s:Fade(a:window) }, { 'repeat': 10 })
endfunction

function! border_window#Move(window)
  function! s:Move(window)
    let opts = a:window.background.opts
    let opts.col = opts.col + 1
    let opts.row = opts.row + 1
    let a:window.main.opts = opts

    call nvim_win_set_config(a:window.background.window, opts)

    let opts = a:window.main.opts
    let opts.col = opts.col + 1
    let opts.row = opts.row + 1
    let a:window.main.opts = opts

    call nvim_win_set_config(a:window.main.window, opts)
  endfunction

  call timer_start(10, { timer -> s:Move(a:window) }, { 'repeat': 3 })
endfunction
