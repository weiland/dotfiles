if pcall(require, 'impatient') then
  require('impatient')
end

-- general neovim options (without plugins)
require('options')
-- autocmds
require('autocmds')
-- general mappings
require('mappings')
-- plugin configurations
require('plugins')
-- colorscheme
require('colorscheme')
