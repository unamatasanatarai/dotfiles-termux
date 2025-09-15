" Enable relative line numbers
set relativenumber
set number  " Also show absolute line number for current line

" Map 'jk' to escape in insert mode
inoremap jk <Esc>

" Set space as leader key
let mapleader = " "

" Ensure hjkl works on wrapped lines (multiline navigation)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Enable syntax highlighting
syntax enable
syntax on

" Configure indentation
set autoindent     " Copy indent from current line when starting a new line
set smartindent    " Smart autoindenting for C-like programs
set tabstop=4      " Number of spaces a tab counts for
set shiftwidth=4   " Number of spaces for each step of (auto)indent
set expandtab      " Convert tabs to spaces
set softtabstop=4  " Number of spaces for tab in insert mode

" Ensure proper display of wrapped lines
set wrap
set linebreak      " Break lines at word boundaries

set scrolloff=3
" Save with <leader>w
nnoremap <leader>w :w<CR>

" Additional suggested settings
set cursorline     " Highlight the current line
set showcmd        " Show partial commands in the last line
set incsearch      " Incremental search (highlight as you type)
set hlsearch       " Highlight all search matches
set ignorecase     " Case-insensitive searching
set smartcase      " Case-sensitive if uppercase is used in search
set wildmenu       " Enhanced command-line completion
set wildmode=list:longest,full  " List all matches and complete to longest
set backspace=indent,eol,start  " Allow backspace over indents, line breaks, etc.
set visualbell     " Use visual bell instead of beeping
set t_vb=          " Disable visual bell flashing
set mouse=a        " Enable mouse support in all modes
set laststatus=2   " Always show the status line
set ruler          " Show cursor position in status line
set showmatch      " Highlight matching brackets/parentheses
set lazyredraw       " Don't redraw while running macros (performance)
set ttyfast          " Speed up redrawing

" Set indentation rules per filetype
augroup FiletypeIndent
  autocmd!
  autocmd FileType python   setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType javascript,typescript,json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html,css,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType lua      setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType make     setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END
filetype plugin indent on

