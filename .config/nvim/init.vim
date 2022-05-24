filetype plugin indent on
call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()


" Looks
set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum"
let &t_8b = "\e[48;2;%lu;%lu;%lum"
let &t_ut=''
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set background=dark
colorscheme onedark
set number
set relativenumber
set cursorline
let g:airline_powerline_fonts = 1
let g:python_recommended_style = 0

" general
set ts=2 sts=1 sw=2
set nosmarttab
set expandtab
set encoding=utf-8
set scrolloff=3
set wrap
set textwidth=79
set formatoptions=qrn1
set noswapfile
set autoread
set mouse=a

" coc.nvim
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

let mapleader = ","
nnoremap j gj
nnoremap k gk

inoremap jj <ESC>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fzf
nmap <C-o> :GFiles<CR>
nmap <C-p> :Buffers<CR>

" search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

autocmd FileType python setlocal omnifunc=omnifunc=jedi#completions
" Reload vimrc on save
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

set completeopt-=preview
