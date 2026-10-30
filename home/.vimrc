" Minimal, plugin-free vim config for servers and quick edits (day-to-day editor is nvim)

syntax on
filetype plugin indent on
silent! colorscheme habamax

set number
set list
set listchars=tab:›\ ,trail:·,nbsp:␣
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set nowrap
set ignorecase
set smartcase
set incsearch
set hlsearch
set clipboard=unnamed
set scrolloff=3
set laststatus=2
set wildmenu
set hidden
set mouse=a

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif
