set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Setup Python hosts for the specific system we're on
if has('macunix')
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('unix')
  let g:python_host_prog  = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
endif
