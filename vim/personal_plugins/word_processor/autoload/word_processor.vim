let s:DEFAULT_FONT = 'inconsolataNerdFontCompleteM-nerd-font-complete-mono-with-ligatures 22'
let s:WORD_PROCESSOR_FONT = 'Cousine 22'
let s:ITERM_PYTHON_BIN = '~/Library/ApplicationSupport/iTerm2/iterm2env/versions/3.7.2/bin/python3'
let s:ITERM_CHANGE_FONT_SCRIPT = '~/dotfiles-etc/vim/personal_plugins/word_processor/scripts/set_terminal_font.py'
let s:ITERM_CHANGE_FONT_CMD = s:ITERM_PYTHON_BIN . ' ' . s:ITERM_CHANGE_FONT_SCRIPT

" Make vim a little more usable for prose
function! word_processor#ToggleWordProcessing()
  if g:word_processing_on  != 1
    " Colorscheme
    let g:disable_color_overrides = 1
    hi clear

    " Turn on softwrap
    setlocal wrap

    " Setup spellcheck
    setlocal spell spelllang=en_gb

    " Add a little bit of extra linespacing
    setlocal linespace=4

    " Clear out any special showbreak symbols
    setlocal showbreak=

    " Enable Pencil
    let g:pencil_higher_contrast_ui = 1
    let g:pencil_neutral_headings = 1
    let g:pencil_spell_undercurl = 1
    let g:pencil_terminal_italics = 1

    setlocal background=light
    colorscheme pencil
    hi Normal guibg=#efefef

    SoftPencil

   " Enable Goyo
    Goyo 80x40

    " Turn off ALE
    ALEDisable

    " Change the iTerm font to the word processor font
    call system(s:ITERM_CHANGE_FONT_CMD . ' "' . s:WORD_PROCESSOR_FONT . '"')

    " Turn off the tmux status line for a real fullscreen experience
    call system('tmux setw status off')

    let g:word_processing_on = 1
  else
    let g:disable_color_overrides = 1

    " Turn Goyo off
    Goyo!

    " Turn Limelight off
    Limelight!

    " Turn ALE back on
    ALEEnable

    " Reset everything else back to the default
    source $MYVIMRC

    " Reset linespacing
    setlocal linespace=1

    " Turn spellchecker off
    setlocal nospell

    " Change the iTerm font back to the default font
    call system(s:ITERM_CHANGE_FONT_CMD . ' "' . s:DEFAULT_FONT . '"')

    " Turn the tmux status line back on
    call system('tmux setw status on')

    let g:word_processing_on = 0
 endif
endfunction
