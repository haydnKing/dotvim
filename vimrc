set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"ctrlP
Plugin 'ctrlpvim/ctrlp.vim'

"solarized
Plugin 'altercation/vim-colors-solarized'

"NERDtree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

"airline
Plugin 'vim-airline/vim-airline'

"YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" searching
set hlsearch
set incsearch
set showmatch
set smartcase
set ignorecase

" behaviour
set backspace=indent,eol,start
set mouse=a
set term=xterm-256color
set modelines=0
"set textwidth=79
set directory=~/.vim/tmp

" tabs and indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

"vim-airline all the time
set laststatus=2

" colors
syntax enable
set background=dark
colorscheme solarized

" key bindings
map <F3> :w !detex \| wc -w<CR>
map <C-F5> :mksession! ~/.vim_session <cr> " Quick write session with F5
map <C-F6> :source ~/.vim_session <cr>     " And load session with F6
map <F10> :setlocal spell spelllang=en_gb<CR>
map <F9> :setlocal nospell<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" latex 
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_GotoError=0

" filetype specific settings

" Recognise antha files as golang
autocmd BufNewFile,BufRead *.an set filetype=go

