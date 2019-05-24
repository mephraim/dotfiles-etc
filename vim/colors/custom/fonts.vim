if has("gui_running")
  if has("gui_macvim")
    " Patched version of Inconsolata with ligatures added.
    set guifont=inconsolataNerdFontCompleteM-nerd-font-complete-mono-with-ligatures:h18
    set macligatures
  else
    set guifont=\Inconsolata-dz\ for\ Powerline\ Medium\ 13
  endif
endif
