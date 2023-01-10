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

Plug 'mileszs/ack.vim'

Plug 'sheerun/vim-polyglot'

Plug 'dense-analysis/ale'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

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

" yay for living in the future and having lots of RAM
set maxmempattern=2000000


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
let g:python3_host_prog = '/usr/bin/python3'
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
       \ 'go': ['gopls', '-logfile', '/tmp/gopls.log'],
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

" ag / ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" ALE mappings for ts/tsx
"
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

autocmd FileType javascript map <buffer> gd :ALEGoToDefinition<CR>
autocmd FileType typescript map <buffer> gd :ALEGoToDefinition<CR>
autocmd FileType typescriptreact map <buffer> gd :ALEGoToDefinition<CR>

autocmd FileType javascript nnoremap <buffer> K :ALEHover<CR>
autocmd FileType typescript nnoremap <buffer> K :ALEHover<CR>
autocmd FileType typescriptreact nnoremap <buffer> K :ALEHover<CR>

autocmd FileType javascript nnoremap <buffer> gr :ALEFindReferences<CR>
autocmd FileType typescript nnoremap <buffer> gr :ALEFindReferences<CR>
autocmd FileType typescriptreact nnoremap <buffer> gr :ALEFindReferences<CR>

autocmd FileType javascript nnoremap <buffer> rn :ALERename<CR>
autocmd FileType typescript nnoremap <buffer> rn :ALERename<CR>
autocmd FileType typescriptreact nnoremap <buffer> rn :ALERename<CR>

nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>

let js_fixers = ['prettier', 'eslint']

let g:ale_fixers = {
  \    '*': ['remove_trailing_lines', 'trim_whitespace'],
  \    'javascript': js_fixers,
  \    'javascript.jsx': js_fixers,
  \    'typescript': js_fixers,
  \    'typescriptreact': js_fixers,
  \    'css': ['prettier'],
  \    'json': ['prettier'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_error = "🐛"
let g:ale_sign_warning = "⚠️"
let g:ale_sign_info = "ℹ"
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "🔥 "

" markdown preview
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'
