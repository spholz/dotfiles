return {
    {
        'j-hui/fidget.nvim',
        opts = {
            progress = {
                display = {
                    done_icon = '✔',
                    progress_icon = { pattern = { '⠂', '⠂', '⠒', '⠲', '⠴', '⠦', '⠆' } },
                },
            },
        },
    },

    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                tab_size = 4,
                max_name_length = 40,
                hover = {
                    enabled = true,
                    delay = 10,
                    reveal = { 'close' },
                },
            },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
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
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- relative path
                    },
                },
                lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            extensions = {
                'quickfix',
                'fzf',
                'man',
                'fugitive',
                'nvim-dap-ui',
                'symbols-outline',
                'toggleterm',
                'lazy',
            },
        },
    },
}
