local lualine = require 'lualine'

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = { 'quickfix', 'fzf', 'man', 'fugitive', 'nvim-dap-ui', 'symbols-outline', 'toggleterm' },
}

-- fix theme for global status line
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colorscheme = vim.fn.expand '<amatch>'
        local lualine_theme = lualine.get_config().options.theme

        if colorscheme == 'molokai' and lualine_theme == 'auto' then
            vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'lualine_c_normal' })
        else
            vim.api.nvim_err_writeln(
                string.format('unknown theme combo: colorscheme: "%s", lualine theme: "%s"', colorscheme, lualine_theme)
            )
        end
    end,
    group = vim.api.nvim_create_augroup('ColorSchemeFixWinSeparator', { clear = true }),
})

vim.cmd [[colorscheme molokai]]
