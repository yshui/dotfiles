"{{{ Utility functions
function! UPDATE_TAGS() "{{{
	let _f_=expand("%:p")
	let _cmd_='ctags -a -f ./tags --fields=+lKiSz --c-kinds=cdefgmnpstuvx --c++-kinds=cdefgmnpstuvx --extra=+q  ' . '"' . _f_ . '"'
	let _resp=system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction "}}}

function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}

function! s:dein_clear_unused() "{{{
	return map(dein#check_clean(), "delete(v:val, 'rf')")
endfunction "}}}

function! s:tmux_apply_title() "{{{
	call system("tmux rename-window \"nvim: ".expand("%:t")."\"")
endfunc "}}}

function! s:tmux_reset_title() "{{{
	call system("tmux set-window-option automatic-rename on")
endfunc "}}}

function! Open_float()
	if exists('*nvim_open_win')
		let b = nvim_create_buf(v:false, v:true)
		call nvim_buf_set_option(b, "buftype", "nofile")
		let opts = {'row':10, 'col':110, 'anchor': 'NE', 'relative': 'win', 'height': 20, 'width': 60}
		let w =  nvim_open_win(b, v:true, opts)
		hi Floating guibg=#000000
		call setwinvar(w, '&winhl', 'Normal:Floating')
		call setwinvar(w, '&number', 0)
	endif
endfunction

command DeinClear call s:dein_clear_unused()
"}}}

"{{{ Dein.vim plugins
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim/
let g:dein#install_process_timeout=99999

call dein#begin(expand('~/.config/nvim/dein/'))

call dein#add('Shougo/dein.vim')
call dein#add('bhurlow/vim-parinfer')
"call dein#add('Shougo/deoplete.nvim', {'merged': 0})
call dein#add('roxma/nvim-yarp')
call dein#add('neoclide/coc.nvim', { 'build': 'yarn install'})
"call dein#add('ncm2/ncm2', {'depends' : ['roxma/nvim-yarp']})
"call dein#add('ncm2/ncm2-bufword', {'depends' : ['ncm2/ncm2']})
"call dein#add('ncm2/ncm2-path', {'depends' : ['ncm2/ncm2']})
"call dein#add('ncm2/ncm2-tmux', {'depends' : ['ncm2/ncm2']})
"call dein#add('ncm2/ncm2-vim', {'depends' : ['ncm2/ncm2']})
"call dein#add('ncm2/ncm2-ultisnips', {'depends' : ['ncm2/ncm2']})
"call dein#add('SirVer/ultisnips')
call dein#add('LnL7/vim-nix')
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('othree/html5.vim')
call dein#add('tpope/vim-surround')
call dein#add('chrisbra/SudoEdit.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('mattn/emmet-vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('jiangmiao/auto-pairs')
call dein#add('rust-lang/rust.vim')
"call dein#add('Raimondi/delimitMate')
call dein#add('Matt-Deacalion/vim-systemd-syntax')
call dein#add('leafgarland/typescript-vim')
"call dein#add('nhooyr/neoman.vim')
call dein#add('junegunn/fzf', {'merged':0})
call dein#add('reasonml-editor/vim-reason-plus')
"call dein#add('kien/ctrlp.vim')
call dein#add('vim-scripts/Lucius')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes', {'depends' : ['vim-airline']})
call dein#add('bling/vim-bufferline')
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })
call dein#add('carlitux/deoplete-ternjs', {'depends': ['deoplete.nvim', 'tern_for_vim']})
"call dein#add('tweekmonster/deoplete-clang2', {'depends' : ['deoplete.nvim'], 'merged': 1})
call dein#add('majutsushi/tagbar')
"call dein#add('rhysd/vim-clang-format')
"call dein#add('lyuts/vim-rtags')
"call dein#add('critiqjo/lldb.nvim')
call dein#add('kana/vim-arpeggio')
"call dein#add('google/vim-maktaba')
"call dein#add('google/vim-codefmt', { 'depends' : ['vim-maktaba'], 'merged': 0})
"call dein#add('google/vim-glaive')
call dein#add('editorconfig/editorconfig-vim')
"call dein#add('arakashic/chromatica.nvim', {'merged': 0})
"call dein#add('mhartington/nvim-typescript', {'depends' : ['deoplete.nvim']})
"call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'make release'})
"call dein#add('yshui/tooltip.nvim')
call dein#add('udalov/kotlin-vim')
call dein#add('junegunn/fzf.vim')
call dein#add('jackguo380/vim-lsp-cxx-highlight')
call dein#add('ziglang/zig.vim')
call dein#add('wsdjeg/dein-ui.vim')
call dein#add('liuchengxu/vim-which-key', {'lazy': 1, 'on_cmd': ['WhichKey', 'WhichKey!']})

call dein#end()
"call maktaba#plugin#Detect()

"call glaive#Install()

if dein#check_install()
  call dein#install()
endif
"}}}

"{{{ Timers

let g:idle_timer = -1
func! s:idle_callback(timer)
	Neomake
endfunc

"Experimenting with long press key map
let g:press_timer = -1
let g:repeat_count = -1
"let g:fzf_layout = { 'window': 'call Open_float()' }

func! s:long_press_j_cancel()
	echomsg "canceled"
	let g:repeat_count = -1
	let g:press_timer = -1
endfunc

func! s:long_press_j()
	if g:press_timer >= 0
		"Called before timer expires, assuming repeated key
		"enter wait mode
		echomsg "repeating"
		let ret = ""
		call timer_stop(g:press_timer)
		if g:repeat_count < 0
			let g:repeat_count = 10
			let ret = "\<backspace>"
		elseif g:repeat_count > 0
			let g:repeat_count -= 1
		endif

		if g:repeat_count == 0
			echomsg "You did it!"
		endif
		let g:press_timer = timer_start(200, 's:long_press_j_cancel', {'repeat': 1})
		return ret
	elseif g:press_timer == -1
		"Just started
		echomsg "starting"
		let g:press_timer = timer_start(200, 's:long_press_j_cancel', {'repeat': 1})
		return "2"
	endif
endfunc
"inoremap <expr> 2 <SID>long_press_j()

"}}}

source $VIMRUNTIME/menu.vim

"{{{ Basic vim configurations

"Set tmux window name and title
autocmd VimEnter * call s:tmux_apply_title()
autocmd BufEnter * call s:tmux_apply_title()
autocmd VimResume * call s:tmux_apply_title()
autocmd VimLeave * call s:tmux_reset_title()
autocmd VimSuspend * call s:tmux_reset_title()
set title
set titlestring=%f\ -\ NVIM

set guifont=Iosevka:h12
"Return to the last edit position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") && expand("%:t") != "COMMIT_EDITMSG" |
  \   exe "normal! g`\"" |
  \ endif
set mouse=a
syntax enable

set noshowmode
set hlsearch
set backup
set backupdir=$HOME/.vimf/backup,.
set directory=$HOME/.vimf/swap,.
set fileencodings=ucs-bom,utf-8,gbk,gb2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set undodir=~/.vimf/undodir
set undofile
set undolevels=1000
set undoreload=10000
set updatetime=4000
set tags=tags;/
set backspace=2
set grepprg=grep\ -nH\ $*
set wildmenu
set cpo-=<
set wcm=<C-Z>
set laststatus=2
set clipboard=unnamedplus
set secure
set nomodeline
map <F4> :emenu <C-Z>
au BufRead,BufNewFile * let b:start_time=localtime()
set completeopt=menuone
set shada=!,'150,<100,/50,:50,r/tmp,s256
set timeoutlen=300
"au FileType c,cpp,vim let w:mcc=matchadd('ColorColumn', '\%81v', 100)

set smartindent
set ofu=syntaxcomplete#Complete
"List Char
"set list!
set listchars=tab:>-,trail:-,extends:>
set viewoptions-=options

"Color Scheme
set background=dark
if v:progname =~? "gvim"
	colors lucius
else
	colorscheme monokai
endif

let g:nvim_config_dir = $HOME."/.config/nvim"
if $XDG_CONFIG_DIR != ""
	let g:nvim_config_dir = $XDG_CONFIG_DIR."/nvim"
endif

if $COLORTERM == "truecolor"
	set termguicolors
endif


filetype plugin on
filetype plugin indent on

"autocmd! BufWritePost * Neomake
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview
"}}}

"{{{ General
let g:mapleader = "\<SPACE>"
let g:maplocalleader = ","

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
"}}}

"{{{ Plugin configurations
let g:tooltip_border_width=10
let g:tooltip_background="white"
let g:tooltip_foreground="black"
"{{{ Clang paths

let g:__clang_path = '/usr/lib/libclang.so'
let g:chromatica#libclang_path = g:__clang_path

"}}}
"{{{ Chromatic
let g:chromatica#highlight_feature_level = 0
let g:chromatica#responsive_mode = 1
let g:chromatica#enable_at_startup = 1
"}}}
"{{{EditorConfig
let g:EditorConfig_preserve_formatoptions=1
"}}}
"{{{Parinfer
"Disable Parinfer filetype commands by default
let g:vim_parinfer_filetypes = []
let g:vim_parinfer_globs = [ "*.el", "*.lisp", "*.scm" ]
"}}}
"{{{ Coc
let g:coc_global_extensions = [ "coc-rust-analyzer", "coc-lists", "coc-json", "coc-tsserver", "coc-syntax", "coc-snippets", "coc-clangd" ]
let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'
"}}}
"{{{ Arpeggio
function! s:chords_setup()
	Arpeggio inoremap ji <ESC>
	Arpeggio inoremap jk <C-\><C-O>:close<CR>
	Arpeggio inoremap wq <C-\><C-O>:wq<CR>
	Arpeggio inoremap fq <C-\><C-O>:q!<CR>
	Arpeggio inoremap wr <C-\><C-O>:w<CR>
	Arpeggio inoremap har <C-\><C-O>:call CocActionAsync("doHover")<CR>
	Arpeggio imap af <C-\><C-O><Plug>(coc-fix-current)
	Arpeggio nmap ac0 v<Plug>(coc-codeaction-selected)
	Arpeggio imap ac0 <C-\><C-O>v<Plug>(coc-codeaction-selected)

	Arpeggio imap eo0 <C-\><C-O><Plug>(coc-diagnostic-prev)
	Arpeggio imap ei0 <C-\><C-O><Plug>(coc-diagnostic-next)
	Arpeggio nmap eo0 <Plug>(coc-diagnostic-prev)
	Arpeggio nmap ei0 <Plug>(coc-diagnostic-next)

	Arpeggio noremap jk :close<CR>
	Arpeggio noremap wq :wq<CR>
	Arpeggio noremap fq :q!<CR>
	Arpeggio noremap wr :w<CR>
	Arpeggio noremap har :call CocActionAsync("doHover")<CR>
	Arpeggio nmap gd <Plug>(coc-definition)
	Arpeggio nmap ref <Plug>(coc-references)
	Arpeggio nmap fm <Plug>(coc-format-selected)
	Arpeggio xmap fm <Plug>(coc-format-selected)
	Arpeggio nmap af <Plug>(coc-fix-current)
	Arpeggio nmap rn <Plug>(coc-rename)
	"Arpeggio imap ag <Plug>(ncm2_expand_longest)
endfunction

autocmd VimEnter * call s:chords_setup()
"}}}

"{{{ AutoPairs/delimitMate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1
let g:AutoPairsMapCR = 0
"}}}

"{{{ airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "wombat"
"}}}

"{{{ clang-format
let g:clang_format#detect_style_file = 1
"}}}

"{{{ SudoEdit
let g:sudo_askpass='/usr/lib/seahorse/ssh-askpass'
let g:sudoDebug=1
"}}}

"{{{ syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_python_exec = '/usr/bin/python'
"let g:syntastic_python_checkers=['python', 'py3kwarn']
"}}}

"{{{ LaTeX
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='xelatex --shell-escape --interaction=nonstopmode $*'
let g:tex_flavor='latex'
"}}}
"{{{ emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"}}}
"}}}

"{{{ FileType configurations

autocmd Filetype c,cpp set comments^=:///
autocmd FileType python set shiftwidth=4
autocmd FileType python set nosmartindent
autocmd FileType cpp set nosmartindent preserveindent
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1  " Rails support
autocmd FileType java setlocal noexpandtab " do not expand tabs to spaces for Java
autocmd FileType rust setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
autocmd FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType markdown set spell spelllang=en_us
autocmd FileType lua set expandtab shiftwidth=4 tabstop=8 softtabstop=4 textwidth=80
autocmd BufNewFile,BufRead *.mi set filetype=mite
au BufNewFile,BufRead meson.build set filetype=meson
au BufNewFile,BufRead meson_options.txt set filetype=meson

"}}}

"{{{ Misc mappings
map <silent> <C-N> :let @/=""<CR>
map <F2> :!/usr/bin/ctags -R --fields=+lKiSz --c-kinds=+cdefgmnpstuvx --c++-kinds=+cdefgmnpstuvx --extra=+q .<CR>
imap <C-n> <esc>nli

inoremap <silent> <F8> <C-\><C-O>:TagbarToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <C-p> <C-\><C-O>:Files<CR>
nnoremap <C-p> :Files<CR>

inoremap <F6> <c-g>u<esc>:call zencoding#expandAbbr(0)<cr>a
"vmap <LeftRelease> "*ygv
"}}}


"{{{ completion related mappings
imap <expr><CR>  "\<CR>\<Plug>AutoPairsReturn"

imap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>is_whitespace() ? "\<TAB>" : coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <F7> <C-\><C-O>:Neomake<CR>
nnoremap <F7> :Neomake<CR>
"}}}

"{{{
nnoremap <leader>lf <C-\><C-O>:call CocAction("format")<CR>
"}}}

"{{{commands
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"}}}

"{{{ Terminal
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <Esc>vs <C-\><C-n>:vsplit \| term<CR>
autocmd TermOpen * setlocal timeoutlen=1000
"}}}

"List Char
set list!
set listchars=tab:>-,trail:-,extends:>

nnoremap ; :

" vim: foldmethod=marker
