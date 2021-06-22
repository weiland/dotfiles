set background=dark

if has('nvim')
  colorscheme jellybeans
elseif has('gui_running')
  set termguicolors
  " let ayucolor="mirage" " light, mirage or dakr
  " colorscheme ayu
  " let g:airline_theme='twofirewatch'
  "let g:airline_theme='one'
  colorscheme one
  let g:one_allow_italics = 1
else
  colorscheme OceanicNext
  " let g:airline_theme='oceanicnext'
  " colorscheme github
  " colorscheme two-firewatch
  " let g:two_firewatch_italics=1
endif
