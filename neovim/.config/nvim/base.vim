set encoding=utf8 nobomb  " UTF-8 without Byte-Order-Mark
set termencoding=utf-8
set nocompatible          " Disable vi compatibility
set ffs=unix,mac,dos      " unix as standard file type

" Use homebrew python
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

set clipboard=unnamedplus " OS clipboard

set ttimeoutlen=50
set updatetime=300 " ms until swap write
set ttyfast
set lazyredraw " prevent redraws in macros

let $LANG='en'
set langmenu=en

set mouse=a                     " enable mouse

if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

filetype plugin indent on
syntax on                       " enable syntax highlighting
set t_Co=256

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab                   " use spaces instead of tabs
set smarttab

set diffopt+=vertical " Always use vertical diffs
set diffopt+=iwhite   " Ignore whitespace updates

set backspace=indent,eol,start  " Backspace deletes like most programs in insert mode (on macOS)
set whichwrap+=<,>,h,l

set list
set listchars=
set listchars+=tab:→\
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿
set colorcolumn=100             " used to be 80
set ruler                       " show the cursor position all the time
set cursorline                  " highlight current line
set report=0                    " Always report changed lines
set synmaxcol=256               " Only highlight the first 200 columns

set signcolumn=yes
set cmdheight=1

set title                       " show filename in window toolbar
set number
set relativenumber
set numberwidth=5
set foldcolumn=1
set scrolloff=3                 " start scrolling 3 lines before
set sidescrolloff=16

set showcmd           " display incomplete commands
set showmode          " show the current mode
set showmatch
set mat=2

set incsearch         " do incremental searching
set wrapscan          " searches wrap around end of the file
set ignorecase        " case insensitive search
set smartcase " try to be smart about cases
set hlsearch " highlight search results
set inccommand=split

" Persistent undo history
if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
set undolevels=1000             " use many levels of undo
set undoreload=1000             " maximum lines to save for undo
set undofile                    " enable persistent undo
set undodir=~/.local/share/nvim/undo/

set nobackup                    " prevent backups
set nowritebackup               " prevent backups
set noswapfile                  " prevent swp files

" Set to auto read when a file is changed from the outside
set autoread " reload files when changed on disk
au FocusGained,BufEnter * checktime " TODO: does not belong here
" set shortmess=atI
set shortmess+=c " Don't pass messages to |ins-completion-menu|. (for coc)

set wildmenu          " enhance command line completion
set browsedir=buffer  " browse files in same directory (as the buffer)

set laststatus=2      " Always display the status line
set display=lastline

set nocindent
set autoindent
set smartindent
set nowrap            " dont wrap lines
set nojoinspaces      " prevent J from adding space
set formatoptions+=j  " Delete comment character when joining commented lines

set autowrite         " Automatically :write before running commands
set autochdir         " Change working directory to open buffer
set nostartofline     " dont jump to col one on switch buffer
set switchbuf=useopen " show already opened files from the quickfix-window instead of opening new buffers

set hidden                  " allow hidden buffers (without saving)
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set noerrorbells
set novisualbell

" Security
set modelines=0
set nomodeline

" Use vims navigator in
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
if exists("*netrw_gitignore#Hide")
    let g:netrw_list_hide=netrw_gitignore#Hide()
endif

" Switch spell checking language
command! British :set spelllang=en_gb
command! American :set spelllang=en_us
command! German :set spelllang=de

" Disabled options
"set textwidth=80 " NOPE
" set colorcolumn=+1
" set esckeys " allow cursor keys in insert mode
" Don’t add empty newlines at the end of files
" set binary
" set noeol
" set backupcopy=yes

