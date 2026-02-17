" Initialisation {{{
call plug#begin('$XDG_DATA_HOME/vim/plugged')
" Toolkits
Plug 'yegappan/lsp'

" Tools
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'

" Little things
Plug 'vim-autoformat/vim-autoformat',	{'on': 'Autoformat'}

" Look
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
"Plug 'embark-theme/vim',				{ 'as': 'embark', 'branch': 'main' }
call plug#end()
" }}}
" Configuration {{{
" yegappan LSP {{{
let lspOpts = #{
			\	showDiagWithVirtualText:	v:true,
			\	diagVirtualTextAlign:		'after',
			\	semantigHighlight:			v:true,
			\	autoHighlight:				v:true,
			\	noNewlineInCompletion:		v:true
			\	}
autocmd User LspSetup call LspOptionsSet(lspOpts)

if executable("rust-analyzer")
	let lspServers = [#{
				\	name:		'rustlang',
				\	filetype:	['rust'],
				\	path:		'rust-analyzer',
				\	args:		[],
				\	syncInit:	v:true
				\	}]
	autocmd User LspSetup call LspAddServer(lspServers)
endif
" }}}

" vim-gitgutter {{{
let g:gitgutter_map_keys=0
" }}}
" delimitMate {{{
let g:delimitMate_expand_cr=1
let g:delimitMate_balance_matchpairs=1
" }}}
" netrw {{{
let g:netrw_home=$XDG_DATA_HOME..'/vim'
let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3
let g:netrw_fastbrowse=2
let g:netrw_special_syntax=1
" }}}

" ayu {{{
let g:ayucolor="dark"
" }}}
" embark-theme {{{
"let g:embark_terminal_italics=1
" }}}
" lightline {{{
let g:lightline={'colorscheme': 'ayu_dark'}
"let g:lightline={'colorscheme': 'embark'}
" }}}
" }}}
" Mappings {{{
nnoremap <f3> :Lex<cr>

nnoremap <leader>ld :LspDiag show<cr>
nnoremap <leader>lh :LspHover<cr>
nnoremap <leader>lj :LspGoto<a-tab>

nnoremap <leader>f :Rg<cr>
nnoremap <leader>e :Files<cr>
nnoremap <leader>b :Buffers<cr>
" }}}

" Additional Vim config {{{
colorscheme ayu

set signcolumn=yes	" For vim-gitgutter
set laststatus=2	" For lightline
" }}}
