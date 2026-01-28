" Plugins {{{
" Configuration {{{
" delimitMate - don't interpret single quotes as quotes due to their meaning as lifetime markers
let b:delimitMate_quotes="\""
" }}}
" Mappings {{{
" ':Cargo' is defined in /usr/share/vim/vim91/ftplugin/rust.vim
nnoremap <f5> :Cargo clippy<cr>
nnoremap <s-f5> :Cargo run<cr>
" }}}
" }}}
" vim:set foldlevel=1:
