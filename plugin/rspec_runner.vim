" Execute open rspec buffer
" Thanks to Ian Smith-Heisters
function! RunSpec(args)
 if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
   let spec = b:rails_root . "/script/spec "
 else
   let spec = "spec"
 end 
 let cmd = ":! " . spec . " % -cfn " . a:args
 execute cmd 
endfunction
 
" Mappings
" run one rspec example or describe block based on cursor position
""map <leader>re :call RunSpec("-l " . <C-r>=line('.')<CR>)
" run full rspec file
"map <leader>rf :call RunSpec("")

