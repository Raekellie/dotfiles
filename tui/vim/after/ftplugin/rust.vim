" Plugins {{{
" Configuration {{{
" delimitMate - don't interpret single quotes as quotes due to their meaning as lifetime markers
let b:delimitMate_quotes="\""
" }}}
" Mappings {{{
nnoremap <f5> :Cargo clippy<cr>
nnoremap <s-f5> :Cargo run<cr>

nnoremap <leader>yj :YcmCompleter GoTo<a-tab>
" }}}
" }}}
" vim:set foldlevel=1:
