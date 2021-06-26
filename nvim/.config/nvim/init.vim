" reset before plugins
filetype off
set shell=bash

" if empty(glob('~/.local/share/nvim/plugged'))
"   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

call plug#begin('~/.local/share/nvim/plugged')
  " Files and navigation
  if isdirectory('/opt/homebrew/opt/fzf')
    Plug '/opt/homebrew/opt/fzf'
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
  endif
  Plug 'junegunn/fzf.vim' " TODO: Add { 'on': ... }
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'jremmen/vim-ripgrep'

  " Themes
  Plug 'ayu-theme/ayu-vim'
  Plug 'mhartington/oceanic-next'
  Plug 'endel/vim-github-colorscheme'
  Plug 'nanotech/jellybeans.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'rakr/vim-one'

  " TMUX
  Plug 'christoomey/vim-tmux-navigator'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive' " :Gblame
  "Plug 'tpope/vim-rhubarb', { 'on': 'Gbrowse' } " GitHub
  " highlight clear SignColumn " does not beling in here
  Plug 'gregsexton/gitv', { 'on': ['Gitv'] }

  " Helpers
  Plug 'editorconfig/editorconfig-vim'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat' " enhance . (for some plugins etc)
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-sleuth' " Heuristically set buffer options
  Plug 'justinmk/vim-sneak'
  "Plug 'tpope/vim-eunuch' " Unix helper
  Plug 'andrewradev/splitjoin.vim' " Switch between single-line and multiline with `gs` and `gJ`
  Plug 'vim-scripts/matchit.zip'
  Plug 'Raimondi/delimitMate'

  "Plug 'janko-m/vim-test', { 'on': ['TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit'] }
  "Plug 'kassio/neoterm'
  "let test#strategy = 'neoterm'

  " IDE feelings (Language Server Clients)
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'antoinemadec/coc-fzf'
  " Plug 'dense-analysis/ale' " Linters

  " Languages
  " Plug 'sheerun/vim-polyglot' " could do most of it
  Plug 'vim-ruby/vim-ruby',    { 'for': 'ruby' }
  Plug 'tpope/vim-bundler',    { 'for': 'ruby' }
  Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
  Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
  "Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
  Plug 'tpope/vim-endwise',    { 'for': ['ruby', 'elixir'] }

  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'mxw/vim-jsx',             { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'leafgarland/typescript-vim'
  Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'javascript.jsx', 'typescript', 'javascript.tsx', 'typescript.tsx'] }
  Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
  Plug 'elzr/vim-json',    { 'for': 'json' }
  " Plug 'jparise/vim-graphql'        " GraphQL syntax
  " Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  " Plug 'ARM9/arm-syntax-vim'
  Plug 'lumiliet/vim-twig', { 'for': 'twig' }

  Plug 'junegunn/rainbow_parentheses.vim', { 'for': [ 'racket', 'scheme', 'lisp' ] }

  " Markdown
  Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
  Plug 'reedes/vim-pencil', { 'for': 'markdown' }
  Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

  " LaTeX
  Plug 'lervag/vimtex', { 'for': 'tex' }
  Plug '907th/vim-auto-save', { 'for': 'tex' }

  " Others
  Plug 'tpope/vim-git'
  Plug 'vim-scripts/SyntaxRange'
  "Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
  "Plug 'cespare/vim-toml', { 'for': 'toml' }
  " Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
  " Plug 'peitalin/vim-jsx-typescript', { 'for': 'tsx' }


  " Unused plugins
  " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Plug 'vim-scripts/ctags.vim'
  " Plug 'terryma/vim-multiple-cursors'
call plug#end()

" restore
set shell=fish " TODO: make sure that it does not break anything
filetype plugin indent on

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" basic vim config

set encoding=utf8 nobomb  " UTF-8 without Byte-Order-Mark
set termencoding=utf-8
set nocompatible          " Disable vi compatibility
set ffs=unix,mac,dos      " unix as standard file type

" Use homebrew python
" let g:python_host_prog = '/usr/local/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3'
" let g:python_host_skip_check = 1
" let g:python3_host_skip_check = 1

set clipboard=unnamedplus " OS clipboard

set ttimeoutlen=50
set updatetime=300 " ms until swap write
set ttyfast
set lazyredraw " prevent redraws in macros

let $LANG='en'
set langmenu=en

set mouse=a                     " enable mouse

" use bash (since fish breaks some things)
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
"set relativenumber
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

" Return to last edit position when opening files (instead of relativenumbers)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

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

" Mappings

" Map Leader to space
nnoremap <SPACE> <NOP> " and make sure SPACE has no other function
let mapleader = " "

" In case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" Exe
" Switch vim tabs with just pressing the tab key
nnoremap <tab> gt
nnoremap <S-tab> gT

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Shortcuts
nnoremap <leader>a :Ag<space>
" nnoremap <leader>n :NERDTreeFind<CR>
" nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>g :GitGutterToggle<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Visual
" j & k with visual lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Insert
" ESC from insert mode
inoremap jj <esc>
" inoremap jk <esc>
" inoremap kk <esc>

" Don't use arrows, resize the window/pane instead
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Disabled options
"set textwidth=80 " NOPE
" set colorcolumn=+1
" set esckeys " allow cursor keys in insert mode
" Don’t add empty newlines at the end of files
" set binary
" set noeol
" set backupcopy=yes

" Colors

if has('nvim')
  colorscheme jellybeans
elseif has('gui_running')
  set termguicolors
  colorscheme one
  let g:one_allow_italics = 1
else
  colorscheme OceanicNext
endif
