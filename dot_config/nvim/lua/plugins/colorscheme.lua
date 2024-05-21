return {
    {
        'tomasr/molokai',
        priority = 1000,
        lazy = false,
        config = function()
            -- fix theme for global status line
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
                    -- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { link = 'CmpItemAbbr' })
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
                        strikethrough = true,
                        -- fg = vim.api.nvim_get_hl_by_name('Comment', true).foreground,
                    })

                    -- fixes for nvim 0.10
                    vim.api.nvim_set_hl(0, '@variable', { link = 'Identifier' })
                    vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })
                    vim.api.nvim_set_hl(0, 'IncSearch', { link = 'Search' })
                end,
                group = vim.api.nvim_create_augroup('color_scheme_fix', { clear = true }),
            })

            vim.cmd.colorscheme 'molokai'
        end,
    },
    { 'sainnhe/sonokai',               lazy = true },
    { 'EdenEast/nightfox.nvim',        lazy = true },
    { 'joshdick/onedark.vim',          lazy = true },
    { 'tomasiser/vim-code-dark',       lazy = true },
    { 'ayu-theme/ayu-vim',             lazy = true },
    { 'NLKNguyen/papercolor-theme',    lazy = true },
    { 'drewtempelmeyer/palenight.vim', lazy = true },
    { 'rebelot/kanagawa.nvim',         lazy = true },
    { 'ray-x/aurora',                  lazy = true },
    {
        'sonph/onehalf',
        lazy = true,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. '/vim')
        end,
    },
    {
        'kyoz/purify',
        lazy = true,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. '/vim')
        end,
    },
    { 'dracula/vim', name = 'dracula', lazy = true },
}
