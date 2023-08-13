local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.do_filetype_lua = 1 -- TODO: Can be removed soon.

o.backup = true
o.backupdir = vim.fn.stdpath('data')..'/backup'
o.clipboard = "unnamedplus"
o.colorcolumn = 100
o.completeopt = "menuone,noinsert,noselect"
o.exrc = true
o.hidden = true
o.inccommand= "nosplit"
o.mouse = "a"
o.showmode = false
o.path="**"
o.scrolloff = 3
o.sidescrolloff = 5
o.secure = true
o.shortmess = o.shortmess..'c'
o.signcolumn = "yes"
o.tags="tags;/,codex.tags;/"
o.termguicolors = true
o.updatetime = 100

wo.cursorline = false
wo.number = true
-- wo.relativenumber = true
wo.wrap = true

bo.modeline = true
bo.swapfile = false
bo.undofile = true

bo.shiftwidth=4
bo.tabstop=4
bo.expandtab = false -- do not expand tab to spaces

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
