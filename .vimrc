set nocompatible

set encoding=utf-8 nobomb " UTF-8 wihtout BOM
set mouse=a

" Eslint, Tern etc have issues with fish
" for $SHELL == /usr/local/bin/fish
set shell=/bin/bash

" Colors
syntax enable
set t_Co=256
if (has("gui_running"))
  set termguicolors
endif
set background=dark

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab

" Make it obvious where 80 characters is
"set textwidth=80 " Breaks text when limit is reached
set colorcolumn=100 " used to be +1

" Numbers
set number
set numberwidth=5

" Show brackets
set showmatch

set backspace=indent,eol,start  " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

hi clear SignColumn " Syntastic and vim-gitgutter put symbols into the sign col

"set noerrorbells
set nostartofline
set shortmess=atI
set showmode " show the current mode
set title " show filename in window toolbar
set autoindent
set nowrap " dont wrap lines
set expandtab " expand tab to spaces
set wildmenu " enhance command line completion
"set esckeys " allow cursor keys in insert mode, is not suppoted in nvim 0.2.0
set scrolloff=3 " start scrolling 3 lines bf horiz win border
set clipboard=unnamed " OS clipboard
set cursorline " highlight current line
set ffs=unix,dos,mac " unix as standard file type
set ic " shorthand for ignorecase (case insensitive search)


" relative line numbers <3
"if exists("&relativenumber")
"  set relativenumber
"  au BufReadPost * set relativenumber
"endif
" fuzzy search
"set rtp+=~/.fzf

" Always use vertical diffs
set diffopt+=vertical

" Persistan undo history
set undofile
set undodir=~/.vim/undodir/

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Map Leader to space
let mapleader = " "

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
inoremap jj <esc>

nnoremap <tab> gt
nnoremap <S-tab> gT
"nnoremap ; : " maps ; to : (which is useful but may teaches bad behaviour)

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Don't use arrows
nnoremap <Left> :echoe "🙄"<CR>
nnoremap <Right> :echoe "🙄"<CR>
nnoremap <Up> :echoe "🙄"<CR>
nnoremap <Down> :echoe "🙄"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" own vim settings (TODO move them to .local)

inoremap <leader>; <C-o>A;
"inoremap ;<cr> <down><end>;<cr>

" j & k with visual lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Run commands that require an interactive shell
" Plugins
call plug#begin('~/.vim/plugged')
"call plug#begin('~/.local/share/nvim/plugged') " neovim
" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'
"Plug 'chriskempson/base16-vim'
"Plug 'trusktr/seti.vim'
"Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
"Plug 'rakr/vim-two-firewatch'
"Plug 'endel/vim-github-colorscheme'
Plug 'nanotech/jellybeans.vim'

" Navigatoin & Files
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'

Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes' " My theme has alreayd an airline theme

" Test these out
"Plugin 'sheerun/vim-polyglot' " Includes all syntax including javascript and jsx package
"Plugin 'christoomey/vim-run-interactive' " Interactive shell :ri
"Plug 'bogado/file-line'
"Plug 'vim-easy-align'
"Plug 'nelstrom/vim-visual-star-search'
"Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
"Plug 'Raimondi/delimitMate'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb', { 'on': 'Gbrowse' }
highlight clear SignColumn
Plug 'gregsexton/gitv'

" Helpers
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " enhance . (for some plugins etc)
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-eunuch' " Unix helper

" Languages
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'elzr/vim-json', { 'on': 'JSON' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
"Plug 'tpope/vim-rails'
"Plug 'thoughtbot/vim-rspec'
"Plug 'kchmck/vim-coffee-script'
Plug 'ARM9/arm-syntax-vim'

Plug 'janko-m/vim-test'
Plug 'vim-scripts/ctags.vim'
Plug 'editorconfig/editorconfig-vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'ternjs/tern_for_vim'

" Markdown
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

" Pandoc support for Markdown
" Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" LaTeX
Plug 'lervag/vimtex', { 'for': 'tex' }
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

Plug '907th/vim-auto-save', { 'for': 'tex' }
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave"]

" Spelling
setlocal spell
set spelllang=en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" disable spelling
set nospell

call plug#end()

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown.pandoc
  autocmd BufRead,BufNewFile *.hamlc set filetype=haml

  " Enable spellchecking for Markdown
  " autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=80
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
augroup END

" Disable adding comment leaader in new line and after hitting <Enter> in Isert mode.
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Format json
com! FormatJSON %!python -m json.tool

" nvim python (for ternjs)
"let g:python_host_prog = '/usr/bin/python'
"let g:python3_host_prog = '/usr/bin/python3'
"let g:python_host_skip_check = 1

" Nerdtree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
noremap <C-n> :NERDTreeToggle<CR>
noremap <leader>n :NERDTreeToggle<CR>

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" CtrlP: Full path fuzzy finder
" Borrowed from @skwp and @bitboxer
let g:ctrlp_working_path_mode = 0
let g:ctrlp_switch_buffer = 'e'

noremap <C-b> :CtrlPBuffer<CR>
let g:ctrlp_dont_split = 'NERD_tree_2'
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

    if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" ack.vim: use ag
let g:ackprg = 'ag -S --nogroup --column'

" Better statusbar
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 17
set laststatus=2

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"let g:syntastic_error_symbol = '❌'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" vim-jsx: Allow JSX in normal js files
let g:jsx_ext_required = 0 " for the mxw/vim-jsx plugin

" Git Gutter: shows a git diff in the gutter
" without any weird color
highlight clear SignColumn

" Open NerdTree for current directory (`vim .`)
if isdirectory(argv(0))
  bd
  autocmd vimenter * exe "cd" argv(0)
  autocmd VimEnter * NERDTree
endif

if(has('nvim'))
  set termguicolors
  let ayucolor="mirage" " light, mirage or dakr
  colorscheme ayu
  let g:airline_theme='oceanicnext'
  "colorscheme one
  "let g:airline_theme='one'
  let g:one_allow_italics = 1
else
  " colorscheme OceanicNext
  colorscheme jellybeans
  "let g:airline_theme='oceanicnext'
  "colorscheme github
  "colorscheme two-firewatch
  "let g:airline_theme='twofirewatch'
  "let g:two_firewatch_italics=1
endif

" When using Operator Mono
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

if has('gui_running')
  "set guifont=Source\ Code\ Pro
  set guifont=Operator\ Mono
  set guioptions-=T  " no toolbar
endif
