-- Bootstrap packer.nvim
local packer_install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    print 'Downloading packer.nvim...'

    local output = vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_install_path,
    }

    print(output)

    -- only this setting is required while bootstrapping (for treesitter)
    vim.o.termguicolors = true

    -- only install plugins, don't load any other config files
    require 'plugins'(true)

    print 'Restart Neovim to complete installation'

    return
end

require 'options'
require 'plugins'(false)
require 'keybindings'
require 'lsp'
require 'completion'
require 'statusline'
require 'diagnostic'
