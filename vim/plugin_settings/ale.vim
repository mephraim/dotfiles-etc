" Ale plugin settings
function! AfterAleInstall(info)
  if a:info.status ==# 'installed' || a:info.force
    call InstallLinters()
  endif
endfunction

" Installs all of the required linters
function! InstallLinters()
  " Alex linter for prose
  !npm install alex --global

  " Vimscript lint
  !pip3 install vim-vint

  " Style linting
  !npm install  stylelint stylelint-config-standard --global
endfunction

command! InstallLinters call InstallLinters()

Plug 'w0rp/ale'

" Open a quickfix window for Ale errors
let g:ale_open_list = 1

" In nvim, the ALE signs can have more than one character
if has('nvim')
  let g:ale_sign_error = '× '
  let g:ale_sign_warning = '× '

" Only use one character for other vims
else
  let g:ale_sign_error = '×'
  let g:ale_sign_warning = '×'
end

" Enable the Ale airline plugin
let g:airline#extensions#ale#enabled = 1

" Set the height of the Ale window to be only 4 lines tall
let g:ale_list_window_size = 5

" Only run Ale when the file has been saved
let g:ale_lint_on_text_changed = 'never'

" Turn on virtual text when it's available
if has('nvim')
  let g:ale_virtualtext_cursor = 1
  "
  " Add a custom prefix to the virtual warnings
  let g:ale_virtualtext_prefix = '↢ '

  let g:ale_floating_preview = 1

  noremap <leader>ale :ALEDetail<CR>
end
