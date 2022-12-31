local o, wo, bo = vim.o, vim.wo, vim.bo
o.backup = true
o.backupdir = vim.fn.stdpath('data')..'/backup'
o.clipboard = "unnamedplus"
o.completeopt = "menuone,noinsert,noselect"
o.exrc = true
o.hidden = true
o.inccommand= "nosplit"
o.showmode = false
o.path="**"
o.secure = true
o.shortmess = o.shortmess..'c'
o.tags="tags;/,codex.tags;/"
o.termguicolors = true
o.updatetime = 100
o.signcolumn = "yes"
o.mouse = "a"

wo.relativenumber = true
wo.number = true
wo.cursorline = true
wo.wrap = true
wo.cursorline = false

bo.expandtab = true
bo.modeline = true
bo.swapfile = false
-- bo.shiftwidth=2
-- bo.tabstop=2
bo.undofile = true

if vim.fn.executable('rg') then
  o.grepprg = "rg -H --no-heading --vimgrep"
  o.grepformat = "%f:%l:%c:%m"
end

local augroup = vim.api.nvim_create_augroup("commands", {})
vim.api.nvim_create_autocmd({"TermOpen"},
{
  group = augroup,
  callback = function()
      vim.wo.relativenumber = false
      vim.wo.number = false
  end,
})

-- cmd [[ augroup commands ]]
-- cmd [[   au! ]]
-- cmd [[   au TermOpen * setlocal nonumber norelativenumber ]]
-- cmd [[   au FileType mail setlocal fo+=aw ]]
-- cmd [[   au FileType gitcommit setlocal spell spelllang=en ]]
-- cmd [[   au FileType make setlocal tabstop=8 ]]
-- cmd[[    au FileType * setlocal shiftwidth=2 ]]
-- cmd [[ augroup end ]]

local map = vim.api.nvim_set_keymap

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