return {
    { 'tpope/vim-fugitive', dependencies = 'tpope/vim-rhubarb' },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },

    'wsdjeg/vim-fetch', -- for filename:line:column
    'tpope/vim-sleuth',
    { 'nvim-lua/plenary.nvim', lazy = true }, -- required by multiple plugins
    { 'rcarriga/nvim-dap-ui', dependencies = 'mfussenegger/nvim-dap' },
}
