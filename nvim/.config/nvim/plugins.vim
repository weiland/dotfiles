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
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf'
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
  Plug 'tpope/vim-rhubarb', { 'on': 'Gbrowse' } " GitHub
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

  Plug 'janko-m/vim-test', { 'on': ['TestFile', 'TestLast', 'TestNearest', 'TestSuite', 'TestVisit'] }
  Plug 'kassio/neoterm'
  let test#strategy = 'neoterm'

  " IDE feelings (Language Server Clients)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
  " Plug 'dense-analysis/ale' " Linters

  " Languages
  " Plug 'sheerun/vim-polyglot' " could do most of it
  Plug 'vim-ruby/vim-ruby',    { 'for': 'ruby' }
  Plug 'tpope/vim-bundler',    { 'for': 'ruby' }
  Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
  Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
  Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
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
  Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
  Plug 'cespare/vim-toml', { 'for': 'toml' }
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
