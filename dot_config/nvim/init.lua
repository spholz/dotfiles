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

    -- only this setting is required while bootstrapping (for treesitter)
    vim.opt.termguicolors = true

    vim.cmd [[packad packer.nvim]]

    if not pcall(require, 'packer') then
        vim.api.nvim_err_writeln('Failed to load packer.nvim!')
        return
    end

    -- only install plugins, don't load any other config files
    require 'plugins'(true)

    print 'Restart Neovim to complete installation'
else
    require 'plugins'(false)
end

require 'config.options'
require 'config.keybindings'
require 'config.diagnostic'
