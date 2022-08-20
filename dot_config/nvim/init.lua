require 'config.options'
require 'config.keybindings'
require 'config.diagnostic'

-- Bootstrap packer.nvim
local packer_install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    -- delete old packer_compiled.lua if it exists
    vim.fn.delete(vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua')

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

    vim.cmd [[packad packer.nvim]]

    if not pcall(require, 'packer') then
        vim.api.nvim_err_writeln 'Failed to load packer.nvim!'
        return
    end

    require 'plugins'(true)
else
    require 'plugins'(false)
end
