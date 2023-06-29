return {
    {
        'j-hui/fidget.nvim',
        branch = 'legacy',
        config = function()
            require('fidget').setup {
                text = {
                    spinner = 'dots_snake',
                    done = '',
                },
            }
        end,
    },

    'mbbill/undotree',
}
