-- fix theme for global status line
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colorscheme = vim.fn.expand '<amatch>'
        local lualine_theme = require('lualine').get_config().options.theme

        if colorscheme == 'molokai' and lualine_theme == 'auto' then
            vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'lualine_c_normal' })
        end
    end,
    group = vim.api.nvim_create_augroup('ColorSchemeFixWinSeparator', { clear = true }),
})

-- don't make 'Special' italic and remove bg
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colorscheme = vim.fn.expand '<amatch>'

        if colorscheme == 'molokai' then
            local old_hl = vim.api.nvim_get_hl_by_name('Special', true)
            vim.api.nvim_set_hl(0, 'Special', {
                fg = old_hl.foreground,
                -- no background color
                -- no italic
            })
        end
    end,
    group = vim.api.nvim_create_augroup('ColorSchemeFixSpecial', { clear = true }),
})

vim.cmd [[colorscheme molokai]]
