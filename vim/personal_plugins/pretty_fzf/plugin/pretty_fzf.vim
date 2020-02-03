function s:GetDefaultOpts()
  " Basic fzf options
  let default_opts = '--layout=reverse --margin=1,2 '

  " Add some custom color options
  let default_opts .= '--color fg:188,hl:103,fg+:222,bg+:-1,hl+:104 --color info:183,prompt:110,spinner:107,pointer:167,marker:215 '

  " Add custom key bindings
  let default_opts .= '-m --bind ctrl-f:preview-page-down,ctrl-b:preview-page-up '

  " If bat is available, use it for prettier output
  let fzf_preview_cmd = 'cat'
  if executable('bat')
    let fzf_preview_cmd = 'bat --color always --theme zenburn --style numbers '
  endif

  " If dev icons are appended, strip the first 2 characters off of fzf's
  " output
  let fzf_output_pattern = '{}'
  if g:fancy_fzf_enable_dev_icons
    let fzf_output_pattern = '{2..}'
  end

  " Add the preview window
  let default_opts .= '--preview "' . fzf_preview_cmd . ' ' . fzf_output_pattern . '"'

  return default_opts
endfunction

function s:InitDefaultOpts()
  " Start with a prettier set of default options
  let $FZF_DEFAULT_OPTS = <sid>GetDefaultOpts()
endfunction

" Count the number of files in the project in a background
function! s:CountProjectFiles()
  function s:OnProjectCountJobEvent(job_id, data, event) dict
    if a:event == 'stdout' && len(join(a:data)) != 0
      call s:HandleProjectFilesCounted(str2nr(join(a:data)))
    endif
  endfunction

  let cmd = $HOME . '/dotfiles-etc/vim/personal_plugins/pretty_fzf/scripts/file_count.sh' 
  let callbacks = {
  \ 'on_stdout': function('s:OnProjectCountJobEvent'),
  \ 'on_stderr': function('s:OnProjectCountJobEvent'),
  \ 'on_exit': function('s:OnProjectCountJobEvent')
  \ }

  call jobstart([cmd], callbacks)
endfunction

" Handle the background count of the number of files in the project
"
" If the number of files of files is under the maximum amount, then enable
" devicons in the window and reinitialize the default options.
function! s:HandleProjectFilesCounted(count)
  if a:count < g:fancy_fzf_devicons_max_file_count
    let g:fancy_fzf_enable_dev_icons = 1
    call <sid>InitDefaultOpts()
  end
endfunction

function s:Init()
  " The devicons code is pretty slow, so we don't want to run it on large
  " projects.  This is an arbitrary max of number files before we don't want to
  " use devicons anymore.
  let g:fancy_fzf_devicons_max_file_count = 400

  " Start out with dev icons disabled
  let g:fancy_fzf_enable_dev_icons = 0

  " Setup the floating window
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.75 } }

  call <sid>InitDefaultOpts()
  call <sid>CountProjectFiles()
endfunction

call s:Init()
