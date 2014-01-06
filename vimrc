" vim is not vi
set nocompatible

" load plugins
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

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
set term=xterm-256color
set modelines=0
set textwidth=79
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

" Powerline appearance
let Powerline_symbols = "unicode"

" searching
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase

" colors
syntax enable
set background=dark
colorscheme solarized
:highlight Normal ctermfg=fg ctermbg=NONE

" key bindings
let mapleader = ","
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

" filetype specific settings
autocmd FileType make setlocal noexpandtab
autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal noexpandtab shiftwidth=2 tabstop=2
autocmd FileType python setlocal textwidth=79
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType tex set sw=2
autocmd FileType tex set spell spelllang=en_gb
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.json set tw=0
autocmd BufNewFile,BufRead *.ebnf set filetype=ebnf

" supertab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
highlight Pmenu ctermbg=238 gui=bold

" matchit
"runtime macros/matchit.vim
