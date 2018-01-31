" vim is not vi
set nocompatible

" load plugins
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'fatih/vim-go' " Amazing combination of features.
Plug 'godoctor/godoctor.vim' " Some refactoring tools
if !has('nvim')
 Plug 'maralla/completor.vim' " or whichever you use
endif
if has('nvim')
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
 Plug 'jodosha/vim-godebug' " Debugger integration via delve
endif

Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" tabs and indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

" behaviour
set backspace=indent,eol,start
set mouse=a
set modelines=0
"set textwidth=79
set directory=~/.vim/tmp

" appearance
set encoding=utf-8
set termencoding=utf-8
set laststatus=2
set colorcolumn=80
set wildmenu
set wildignore=*.pyc
set title
set showcmd
set showmode
set visualbell
set nofoldenable
set ruler


" NERDTree settings

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"toggle with space
nnoremap <silent> <Space> :NERDTreeToggle<CR>


" searching
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase

set number

" colors
syntax enable
set background=dark
colorscheme solarized
:highlight Normal ctermfg=fg ctermbg=NONE

" key bindings
let mapleader = ";"
map <silent> <leader><space> ;noh<CR>
map <F3> :w !detex \| wc -w<CR>
map <C-F5> :mksession! ~/.vim_session <cr> " Quick write session with F5
map <C-F6> :source ~/.vim_session <cr>     " And load session with F6
map <F10> :setlocal spell spelllang=en_gb<CR>
map <F9> :setlocal nospell<CR>
nnoremap <leader>v V`]
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
nnoremap ' `
nnoremap ` '
set pastetoggle=<F2>

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_GotoError=0

" filetype specific settings
autocmd FileType make setlocal noexpandtab
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal noexpandtab shiftwidth=2 tabstop=2
autocmd Filetype gitcommit setlocal spell textwidth=72

