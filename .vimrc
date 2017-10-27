syntax on

set list
set number relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set nowrap
set cursorline
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
Plug 'kchmck/vim-coffee-script'

call plug#end()

colorscheme tender
let g:airline_theme = 'tender'

let g:ale_linters = {'javascript': ['eslint']}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
hi ALEErrorSign guifg=#f43753 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi ALEWarningSign guifg=#ffc24b ctermfg=215 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

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

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

let g:ctrlp_custom_ignore = '\v[\/](node_modules|venv|bower_components|dist)|(\.(swp|ico|git))$'

