set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Setup Python hosts for the specific system we're on
if has('macunix')
  let g:python_host_prog  = '/usr/bin/python'
  let g:python3_host_prog = '/Users/ephraim/.asdf/shims/python3'
elseif has('unix')
  let g:python3_host_prog = '/usr/bin/python3'
endif

lua << EOF
  require('plugins/init')
EOF
