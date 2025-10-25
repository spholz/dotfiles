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
}
