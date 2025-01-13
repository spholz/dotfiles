return {
    {
        'tomasr/molokai',
        priority = 1000,
        lazy = false,
        config = function()
            -- various colorscheme fixes for modern nvim
            vim.api.nvim_create_autocmd('ColorScheme', {
                callback = function()
                    local colorscheme = vim.fn.expand '<amatch>'

                    if colorscheme ~= 'molokai' then
                        return
                    end

                    local lualine_ok, lualine = pcall(require, 'lualine')
                    if lualine_ok then
                        local lualine_theme = lualine.get_config().options.theme
                        if lualine_theme == 'auto' or lualine_theme == 'molokai' then
                            vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'lualine_c_normal' })
                            vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#272828' })
                        end
                    end

                    local old_hl = vim.api.nvim_get_hl(0, { name = 'Special' })
                    vim.api.nvim_set_hl(0, 'Special', {
                        fg = old_hl.fg,
                        -- no background color
                        -- no italic
                    })

                    -- for document highlights
                    vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'Visual' })
                    vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3a4c38' })
                    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#513838' })

                    -- nvim-cmp
                    -- mark deprecated completions strikethrough
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
                        strikethrough = true,
                    })

                    vim.api.nvim_set_hl(0, 'NonText', { link = 'Comment' })

                    vim.api.nvim_set_hl(0, 'Added', { fg = '#a6e22e', bg = '#232526' })
                    vim.api.nvim_set_hl(0, 'Changed', { fg = '#66d9ef', bg = '#232526' })
                    vim.api.nvim_set_hl(0, 'Removed', { fg = '#f92672', bg = '#232526' })

                    -- fixes for nvim 0.10
                    vim.api.nvim_set_hl(0, '@variable', { link = 'Identifier' })
                    vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })
                    vim.api.nvim_set_hl(0, 'IncSearch', { link = 'Search' })
                    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#f92672' })
                    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#e6db74' })
                end,
                group = vim.api.nvim_create_augroup('color_scheme_fix', {}),
            })

            vim.cmd.colorscheme 'molokai'
        end,
    },
}
