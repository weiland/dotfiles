# Neovim config

## Requirements

- nix (with flakes and ideally home-manager)
- neovim (v0.9.0 or newer with lua 2.1.0 or newer)

## Packages

are installed via nix.

- impatient
- nvim-lspconfig
- null-ls
- nvim-lsputils
- nvim-lightbulb
- trouble-nvim
- ...
- nvim-cmp
- telescope-nvim
- luasnip
- jellybeans-nvim
- vim-* basics


## Features

### Neovim Features

- async, fast, good defaults
  (https://neovim.io/doc/user/vim_diff.html#nvim-defaults)
- LSP client
- editorconfig support


## Preferences

- leader is `<space>`
- relative line numbers
- reopen at last position
- change workdirectory to buffer (`browsedir=buffer` and `autochdir`)

## Lua Gotchas

- use `vim.keymap.set` over `vim.api.nvim_set_keymap`
- `vim.keymap.set` is by default nonrecursive (`noremap`) (if _rhs_ is also a
  mapping, then `{ remap = true }` should be set
- local variables (`let g:var1 = 1`) are `vim.g.var1 = 1`
