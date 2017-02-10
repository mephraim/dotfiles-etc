if has("gui_running")
  if has("gui_macvim")
    " Patched version of Inconsolata downloaded from https://github.com/ryanoasis/nerd-fonts
    set guifont=\Inconsolata\ for\ Powerline\ Nerd\ Font\ \Complete\ Mono:h16
  else
    set guifont=\Inconsolata-dz\ for\ Powerline\ Medium\ 13
  endif
endif
