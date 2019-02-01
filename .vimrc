syntax on

set list
set number " relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
" set autoindent
" set smartindent
set backspace=indent,eol,start
set nowrap
" set cursorline
" set conceallevel=0
set ignorecase
set smartcase
set incsearch
set clipboard=unnamed
set listchars=tab:› 

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
Plug 'jparise/vim-graphql'
Plug 'kchmck/vim-coffee-script'
Plug 'mkitt/tabline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'alvan/vim-closetag'
Plug 'mileszs/ack.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

colorscheme tender
let g:airline_theme = 'tender'
hi Normal guibg=NONE ctermbg=NONE
hi Visual term=reverse cterm=reverse guibg=Grey

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'graphql': ['gqlint'],
\   'typescript': ['tslint'],
\}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'
let g:airline#extensions#ale#enabled = 1
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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --hidden -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" NERD Commenter
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1


" vim-closetag
" https://github.com/alvan/vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'


" ack.vim
" https://github.com/mileszs/ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" Highlight non-breaking spaces
" :match Error /\%xA0/
"set conceallevel=1
syn match NBSP '\%xa0' conceal cchar=␣
syn match NarrowNBSP '\%u202F' conceal cchar=⸤
