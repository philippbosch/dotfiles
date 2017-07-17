syntax on

set list
set number
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set nowrap
" set conceallevel=0

filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'othree/yajs.vim'
" Plug 'Yggdroot/indentLine'
Plug 'jacoborus/tender.vim'

call plug#end()

colorscheme tender
let g:airline_theme = 'tender'

let g:ale_linters = {'javascript': ['eslint']}
let g:ale_sign_column_always = 1
" let g:ale_sign_error = '•'
" let g:ale_sign_warning = '•'
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

