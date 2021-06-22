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
