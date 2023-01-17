local map = vim.api.nvim_set_keymap
local opts = { silent = true }

vim.go.vimtex_view_method = 'skim'

map('n', '<localleader>v', '<plug>(vimtex-view)', opts)
