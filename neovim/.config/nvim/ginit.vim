" VimR (GUI)

set termguicolors

let ayucolor='mirage' " light, mirage or dakr
colorscheme ayu " or 'one'
" let g:airline_theme = 'oceanicnext' " or 'one'
" let g:one_allow_italics = 1

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

"set guifont=Source\ Code\ Pro
set guifont=Operator\ Mono
set guioptions-=T  " no toolbar
