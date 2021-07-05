" vim is not vi
set nocompatible

" load plugins
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" A dependency of 'ncm2'.
Plug 'roxma/nvim-yarp'

" v2 of the nvim-completion-manager.
Plug 'ncm2/ncm2'

" LanguageClient
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI. < for Language Client
Plug 'junegunn/fzf'

Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'OmniSharp/omnisharp-vim'

Plug 'mileszs/ack.vim'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'ajorgensen/vim-markdown-toc'

Plug 'stevearc/vim-arduino'

" Initialize plugin system
call plug#end()

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

set splitbelow
set splitright

"More natural split manipulation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"toggle with space
nnoremap <silent> <Space> :NERDTreeToggle<CR>
nnoremap <silent> <C-Space> :NERDTreeFind<CR>


" searching
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase
" search for currently selected
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

set number

" colors
syntax enable
autocmd BufEnter * :syntax sync fromstart
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
let g:python3_host_prog = '/Users/hjk/.pyenv/versions/neovim3/bin/python'
" Ali: to indent json files on save
com! JSON %!jq '.'

" completion
autocmd BufEnter  *  call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" complete with ctrl-space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" LanguageClient configuration

" Required for operations modifying multiple buffers like rename.
set hidden

" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls', '-logfile', '/tmp/gopls.log', '-rpc.trace', '--debug=localhost:6060'],
      \ 'typescriptreact': ['typescript-language-server', '--stdio']
       \ }
let g:LanguageClient_changeThrottle = 1.5
" Run gofmt and goimports on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
com! GoFmt %!gofmt -s

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" C-Sharp
let g:OmniSharp_server_stdio = 1
autocmd BufWritePre *.cs exec 'OmniSharpCodeFormat'

" ag / ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack
