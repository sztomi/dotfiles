filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'neovim/nvim-lspconfig'
Plug 'pechorin/any-jump.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'xiyaowong/virtcolumn.nvim'
call plug#end()

runtime! macros/matchit.vim

" LSP
lua require "config.lsp" 
nnoremap <silent> <C-d> :lua toggle_virtual_text()<CR>

" Looks
set termguicolors
colorscheme onehalflight
set background=light
set number
set relativenumber
set cursorline
set noshowmode  " shown by lightline
let g:lightline = { 'colorscheme': 'one' }

" general
set ts=4 sts=4 sw=4
set expandtab
let g:python_recommended_style=0  " ffs
set encoding=utf-8
set scrolloff=3
set wrap
set textwidth=99
set colorcolumn=99
set formatoptions=qrn1
set noswapfile
set autoread
set mouse=a
set fixeol
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fzf
nmap <C-o> :GFiles<CR>
nmap <M-o> :GFiles<CR>
nmap <C-p> :Buffers<CR>
nmap <M-p> :Buffers<CR>
nmap <C-k> :Files<CR>
nmap <C-t> :BTags<CR>
nmap <M-t> :BTags<CR>

" search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" tags
nmap <silent> <leader>t :TagbarToggle f<CR>
let g:gutentags_cache_dir = $HOME . "/Library/Cache/.gutentags"
set completeopt-=preview

" CHADtree
nnoremap <silent> <leader>v :CHADopen<cr>
nnoremap <silent> <leader>l :call setqflist([])<cr>

" vimrc convenience
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
