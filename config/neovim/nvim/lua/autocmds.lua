local cmd = vim.cmd

-- Hightlight selection on yank
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'