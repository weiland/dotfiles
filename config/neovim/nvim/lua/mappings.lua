local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

map('n', '<leader><leader>', '<c-^>', { noremap=true, silent=true})
map('n', '<tab>', 'gt', { noremap=true, silent=true})
map('n', '<S-tab>', 'gT', { noremap=true, silent=true})
map('n', '<C-j>', '<C-w>j', { noremap=true, silent=true})
map('n', '<C-k>', '<C-w>k', { noremap=true, silent=true})
map('n', '<C-h>', '<C-w>h', { noremap=true, silent=true})
map('n', '<C-l>', '<C-w>l', { noremap=true, silent=true})
map('i', 'jj', '<esc>', { noremap=true, silent=true})

map('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap=true, silent=true})
-- map('n', '<C-l>', ':nohl<CR>', { noremap=true, silent=true})
map('n', '<F1>', '<nop>', { noremap=true, silent=true})