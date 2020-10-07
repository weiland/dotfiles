let g:fzf_command_prefix = 'Fzf'
nnoremap <Leader>b :FzfBuffers<CR>
nnoremap <Leader>h :FzfHistory<CR>

" replace ctrl-p command
nnoremap <C-p> :Files<cr>

let g:fzf_files_options =
  \ '--reverse ' .
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

if executable('rg')
  set grepprg=rg\ --color=never
  let $FZF_DEFAULT_COMMAND='rg --files -g "" --hidden'
elseif executable('ag')
  set grepprg=ag\ --nocolor
  " let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --hidden -g ""'
endif
