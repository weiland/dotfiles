if pcall(require, 'impatient') then
  require('impatient')
end

-- general neovim options
require('settings')
-- autocmds
require('autocmds')
-- general mappings
require('mappings')
-- plugin configurations
require('plugins')