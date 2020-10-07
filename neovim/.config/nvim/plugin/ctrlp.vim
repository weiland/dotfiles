" let g:ctrlp_user_command = 'rg %s --files-with-matches -g "" --ignore ".git"'
" let g:ctrlp_user_command = {
"   \ 'types': {
"     \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
"     \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"     \ },
"   \ 'fallback': 'find %s -type f'
"   \ }
" let g:ctrlp_user_command['fallback'] = 'fd --type f --hidden --color never . %s'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_use_caching = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_by_filename = 1
set grepprg=rg\ --color=never\ --vimgrep
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
