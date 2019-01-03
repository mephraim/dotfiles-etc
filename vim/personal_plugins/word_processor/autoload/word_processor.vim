" Make vim a little more usable for prose
function! word_processor#ToggleWordProcessing()
  if g:word_processing_on  != 1
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

    " Turn off deoplete autocompletion in favor of manually triggering it for
    " spelling suggestions
    call deoplete#custom#option({
    \ 'auto_complete': v:false,
    \ 'smart_case': v:true,
    \ })

    " Allow deoplete spelling completion to be triggered with ctrl + space
    inoremap <buffer><silent><expr> <C-Space> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

    " Enable Goyo
    Goyo 80x45

    let g:word_processing_on = 1
  else
    let g:disable_color_overrides = 1

    " Turn Goyo off
    Goyo!

    " Turn Limelight off
    Limelight!

    " Reset everything else back to the default
    source $MYVIMRC

    " Reset linespacing
    setlocal linespace=1

    let g:word_processing_on = 0

    " Turn deoplete back on
    call deoplete#custom#option({
    \ 'auto_complete': v:true,
    \ })
 endif
endfunction
