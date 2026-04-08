vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/akinsho/bufferline.nvim',
})

require('bufferline').setup {
    options = {
        tab_size = 4,
        max_name_length = 40,
        hover = {
            enabled = true,
            delay = 10,
            reveal = { 'close' },
        },
    },
}
