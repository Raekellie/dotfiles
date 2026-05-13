" Initialisation {{{
call plug#begin('$XDG_DATA_HOME/vim/plugged')
" Toolkits
Plug 'yegappan/lsp'

" Tools
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'

" Little things
Plug 'vim-autoformat/vim-autoformat'

" Look
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
call plug#end()
" }}}
" Configuration {{{
" yegappan LSP {{{
if IsInRtp('lsp/lsp.vim')
	nnoremap <leader>ld :LspDiag show<cr>
	nnoremap <leader>lh :LspHover<cr>
	nnoremap <leader>lj :LspGoto<a-tab>

	let lspOpts = #{
				\	showDiagWithVirtualText:	v:true,
				\	diagVirtualTextAlign:		'after',
				\	semantigHighlight:			v:true,
				\	autoHighlight:				v:true,
				\	noNewlineInCompletion:		v:true
				\	}
	autocmd User LspSetup call LspOptionsSet(lspOpts)

	if executable('rust-analyzer')
		let lspServers = [#{
					\	name:		'rustlang',
					\	filetype:	['rust'],
					\	path:		'rust-analyzer',
					\	args:		[],
					\	rootSearch:	['Cargo.toml', '.git'],
					\	syncInit:	v:true
					\	}]
		autocmd User LspSetup call LspAddServer(lspServers)
	endif
	if executable('nil')
		let lspServers = [#{
					\	name:		'nil',
					\	filetype:	['nix'],
					\	path:		'nil',
					\	args:		[],
					\	rootSearch:	['flake.nix', '.git'],
					\	syncInit:	v:true
					\	}]
		autocmd User LspSetup call LspAddServer(lspServers)
	endif
endif
" }}}

" vim-gitgutter {{{
if IsInRtp('gitgutter.vim')
	let g:gitgutter_map_keys=0

	set signcolumn=yes
endif
" }}}
" delimitMate {{{
if IsInRtp('delimitMate.vim')
	let g:delimitMate_expand_cr=1
	let g:delimitMate_balance_matchpairs=1
endif
" }}}
" vim-autoformat {{{
if IsInRtp('autoformat.vim')
	let g:formatdef_alejandra = '"alejandra"'
	let g:formatters_nix = ['alejandra']

	augroup onwrite_format
		autocmd!
		autocmd BufWrite *.{asm,c,h,cpp,hpp,rs,sh,zsh,py,vim,nix,yaml} :Autoformat
	augroup END
endif
" }}}
" netrw {{{
if IsInRtp('netrwPlugin.vim')
	nnoremap <f3> :Lex<cr>

	let g:netrw_home=$XDG_DATA_HOME..'/vim'
	let g:netrw_banner=0
	let g:netrw_winsize=10
	let g:netrw_liststyle=3
	let g:netrw_fastbrowse=2
	let g:netrw_special_syntax=1
endif
" }}}

" ayu {{{
if IsInRtp('ayu.vim')
	let g:ayucolor='dark'

	silent! colorscheme ayu
endif
" }}}
" lightline {{{
if IsInRtp('lightline.vim')
	set laststatus=2

	if g:colors_name == "ayu" " This global is set by convention, it isn't mandatory
		let g:lightline={'colorscheme': 'ayu_dark'}
	endif
endif
" }}}
" }}}
" Mappings {{{
"nnoremap <leader>f :Rg<cr>
"nnoremap <leader>e :Files<cr>
"nnoremap <leader>b :Buffers<cr>
" }}}
