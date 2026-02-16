" Core & Initialization
set nocompatible                " Ensure Vim behaves in a modern way
set encoding=UTF-8              " Set default encoding to UTF-8
set fileformat=unix             " Use Unix line endings
filetype off                    " Reset filetype detection (re-enabled later)

" General Configuration
set path=.,**,**                " Search current dir and recursively
set runtimepath+=~/.config/vim  " Add custom runtime path
set noswapfile                  " Disable swap files
set noerrorbells                " Disable beeps
set visualbell                  " Use visual bell...
set t_vb=                       " ...but disable the flashing
set updatetime=100              " Faster update time (ms)
set timeout                     " Enable timeout for mappings
set timeoutlen=200              " Timeout for mappings (ms)
set ttimeoutlen=10              " Fast timeout for key codes (ms)
set viminfo='50,<1000,s100,h,!  " Save history/marks configuration
set backspace=indent,eol,start  " Allow backspace over everything
set complete-=i                 " Exclude included files from completion
set nrformats-=octal            " Treat numbers as decimal
set grepprg=grep\ -HRIn\ $*     " Use grep for :grep

" Persistent Undo & History
if has("persistent_undo")
    let target_path = expand('~/.local/state/vim/undo')
    " Create the directory if it doesn't exist
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir = target_path
    set undofile                   " Enable persistent undo
endif
set history=1000                   " Increase command line history
set undolevels=1000                " Increase undo levels
set undoreload=10000               " Save whole buffer for undo when reloading

" UI & Visuals
syntax on                       " Enable syntax highlighting
set background=dark             " Optimize for dark themes
" colorscheme amber               " Set color scheme

if has("termguicolors")
    set termguicolors           " Enable true color support
endif

set number                      " Show absolute line number
set relativenumber              " Show relative line numbers
set cursorline                  " Highlight current line
set ruler                       " Show cursor position
set laststatus=2                " Always show status line
set showcmd                     " Show partial commands
set showmatch                   " Highlight matching brackets
set matchtime=1                 " Tenths of a second to show match
set lazyredraw                  " Don't redraw during macros
set ttyfast                     " Faster redrawing
set display+=lastline           " Show as much of last line as possible
set synmaxcol=20000             " Limit syntax highlighting for perf
set list                        " Show special characters
set listchars=tab:▷\ ,trail:·,nbsp:␣,extends:»,precedes:«

set scrolloff=4                 " Keep 4 lines visible vertically
set sidescrolloff=5             " Keep 5 columns visible horizontally

" Indentation & Formatting
set tabstop=4                   " Spaces a tab counts for
set shiftwidth=4                " Spaces for each indent step
set softtabstop=4               " Spaces for tab in insert mode
set expandtab                   " Convert tabs to spaces
set smarttab                    " Smart tab handling
set shiftround                  " Round indent to multiple of shiftwidth

set nowrap                      " Don't wrap long lines
set linebreak                   " Break lines at word boundaries
set textwidth=88                " Max line width
set nofoldenable                " Disable code folding by default
set formatoptions-=t            " Disable automatic line breaking on typing
filetype plugin indent on

" Auto-indentation settings (Disabled per user preference for pasting)
set autoindent                  " Do copy indent from current line
set smartindent                 " Do use smart indenting
autocmd InsertLeave * set nopaste " Turn off paste mode when leaving insert

" Search & Completion
set incsearch                   " Highlight matches as you type
set hlsearch                    " Highlight all search matches
set ignorecase                  " Case-insensitive searching
set smartcase                   " Case-sensitive if uppercase used

set wildmenu                    " Enhanced command-line completion
set wildmode=longest:full,full  " Completion mode
set wildignorecase              " Case-insensitive file completion
set wildignore+=*.pyc,node_modules/**,__pycache__/**,venv/**

" Key Mappings
let mapleader = " "             " Set space as leader key

" Navigation
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Insert mode escapes
inoremap <silent> jk <Esc>
inoremap <silent> kj <Esc>

" Shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
" check what is under cursor
nnoremap <leader>i :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>


" AutoCommands
" Makefiles (Strict Tabs)
autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4

" GOLang
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" JSON
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2

" Bash / Shell
autocmd FileType sh,bash,zsh setlocal expandtab shiftwidth=4 tabstop=4

" Python (PEP 8 Standards)
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal colorcolumn=+1
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal fileformat=unix

" C / C++ (clang-format Microsoft style compatible)
augroup c_microsoft_style
    autocmd!
    autocmd FileType c,cpp,h,hpp setlocal
                \ expandtab
                \ tabstop=4
                \ shiftwidth=4
                \ softtabstop=4
                \ textwidth=120
                \ cindent
                \ cinoptions=:0,l1,g0,(0
                \ formatoptions-=t
                \ formatoptions+=croq

    " ------------------------------------------------------------
    " clang-format (range-aware, Microsoft fallback)
    " ------------------------------------------------------------

    function! s:ClangFormatRange(line1, line2)
        let l:view = winsaveview()

        let l:cmd = 'clang-format-mp-20'

        " If no .clang-format is found, fall back to Microsoft style
        if empty(findfile('.clang-format', '.;'))
            let l:cmd .= ' -style=Microsoft'
        endif

        execute a:line1 . ',' . a:line2 . '!' . l:cmd

        call winrestview(l:view)
    endfunction

    " Define a range-aware command
    command! -range=% ClangFormat call <SID>ClangFormatRange(<line1>, <line2>)

    " Key mappings
    nnoremap <leader>f :ClangFormat<CR>
    vnoremap <leader>f :ClangFormat<CR>
augroup END
