" Make vim a little more usable for prose
function! s:turnOnWordProcessing()
  " Colorscheme
  let g:disable_color_overrides = 1
  hi clear
  set bg=light
  colorscheme pencil
  AirlineTheme pencil

  " Set the font
  set guifont=Courier:h20

  " Turn on softwrap
  setlocal wrap

  " Setup spellcheck
  setlocal spell spelllang=en_gb

  " Add a little bit of extra linespacing
  setlocal linespace=4

  " Clear out any special showbreak symbols
  setlocal showbreak=

  " Enable Pencil
  let g:pencil_higher_contrast_ui = 0
  let g:pencil_neutral_code_bg = 0
  let g:pencil_spell_undercurl = 1
  SoftPencil

  " Enable Goyo
  Goyo 80
endfunction

command! WordProcessorOn :call <SID>turnOnWordProcessing()
command! WordProcessorOff :source $MYVIMRC
