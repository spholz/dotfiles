return {
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup()
        end,
    },

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

    {
        'akinsho/toggleterm.nvim',
        config = function()
            -- setting open_mapping to '<Leader><CR>' seems to be buggy (space is mapped in insert mode?)
            require('toggleterm').setup()

            local Terminal = require('toggleterm.terminal').Terminal
            local term = Terminal:new {
                direction = 'float',
            }

            local map_with_desc = require('util.keymap').map_with_desc

            map_with_desc('n', '<Leader><CR>', function()
                term:toggle()
            end, { noremap = true }, 'Toggle floating terminal')
        end,
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                '*',
            }, {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = false,
                rgb_fn = true,
                hsl_fn = true,
                mode = 'background',
            })
        end,
    },

    'mbbill/undotree',
}
