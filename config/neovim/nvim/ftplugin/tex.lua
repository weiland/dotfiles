local map = vim.api.nvim_set_keymap
local opts = { silent = true }

vim.g.tex_flavor = 'latex'
vim.g.vimtex_compiler_method = 'latexmk'

vim.g.vimtex_view_method = 'skim' -- still opens Preview.app :c
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_activate = 1

-- fix the not working Skim by setting it manually
vim.g.vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
vim.g.vimtex_view_general_options = '-r @line @pdf @tex'

-- vim.g.vimtex_view_general_options_latexmk = '-r' -- deprecated, but works
-- vim.g.vimtex_latexmk_options = '-lualatex -verbose' -- deprecated
vim.g.vimtex_fold_enabled = 0

vim.g.vimtex_quickfix_open_on_warning = 0

vim.g.maplocalleader = ' '

map('n', '<localleader>v', '<plug>(vimtex-view)', opts)
map('n', '<localleader>c', '<Cmd>update<CR><Cmd>VimtexCompile<CR>', opts)
