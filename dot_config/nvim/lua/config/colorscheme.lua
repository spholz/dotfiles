-- fix theme for global status line
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colorscheme = vim.fn.expand '<amatch>'

        if colorscheme == 'molokai' then
            local lualine_ok, lualine = pcall(require, 'lualine')
            if lualine_ok then
                local lualine_theme = lualine.get_config().options.theme
                if lualine_theme == 'auto' or lualine_theme == 'molokai' then
                    vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'lualine_c_normal' })
                end
            end

            local old_hl = vim.api.nvim_get_hl_by_name('Special', true)
            vim.api.nvim_set_hl(0, 'Special', {
                fg = old_hl.foreground,
                -- no background color
                -- no italic
            })

            -- for document highlights
            vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'Visual' })
        end

        -- nvim-cmp
        if packer_plugins['nvim-cmp'] then
            -- mark deprecated completions strikethrough
            -- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { link = 'CmpItemAbbr' })
            vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
                strikethrough = true,
                -- fg = vim.api.nvim_get_hl_by_name('Comment', true).foreground,
            })
        end
    end,
    group = vim.api.nvim_create_augroup('color_scheme_fix', { clear = true }),
})

vim.cmd [[colorscheme molokai]]
