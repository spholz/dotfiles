-- Bootstrap packer.nvim
local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})

    -- only install plugins, don't load any other config files

    -- only this setting is required while bootstrapping (for treesitter)
    vim.o.termguicolors = true

    require'plugins'
    return
end

require'settings'
require'plugins'
require'keybindings'
require'lsp'
require'completion'
