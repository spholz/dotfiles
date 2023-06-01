return {
    {
        'j-hui/fidget.nvim',
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
