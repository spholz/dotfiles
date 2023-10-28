return {
    { 'tpope/vim-fugitive',    dependencies = 'tpope/vim-rhubarb' },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },

    'wsdjeg/vim-fetch',                       -- for filename:line:column
    { 'nvim-lua/plenary.nvim', lazy = true }, -- required by multiple plugins
}
