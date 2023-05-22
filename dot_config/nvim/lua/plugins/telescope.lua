return {
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {},
                    },
                },
            }

            local map_with_desc = require('util.keymap').map_with_desc
            local telescope_builtin = require 'telescope.builtin'

            local opts = {
                noremap = true,
                silent = true,
            }

            map_with_desc('n', '<Leader>R', telescope_builtin.oldfiles, opts, 'Telescope: list previously opened files')
            map_with_desc('n', '<Leader><Leader>', telescope_builtin.buffers, opts, 'Telescope: list open buffers')
            map_with_desc(
                'n',
                '<Leader>/',
                telescope_builtin.current_buffer_fuzzy_find,
                opts,
                'Telescope: fuzzy find in current buffer'
            )

            map_with_desc('n', '<Leader>t', telescope_builtin.builtin, opts, 'Telescope: list builtin pickers')

            map_with_desc(
                'n',
                '<Leader>o',
                telescope_builtin.find_files,
                opts,
                'Telescope: search for files (respecting .gitignore)'
            )
            map_with_desc('n', '<Leader>h', telescope_builtin.help_tags, opts, 'Telescope: search help tags')
            map_with_desc(
                'n',
                '<Leader>g',
                telescope_builtin.live_grep,
                opts,
                'Telescope: live grep (respecting .gitignore)'
            )
            map_with_desc('n', '<Leader>s', telescope_builtin.grep_string, opts, 'Telescope: grep string under cursor')
            map_with_desc('n', '<Leader>d', telescope_builtin.diagnostics, opts, 'Telescope: list diagnostics')
        end,
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
            require('telescope').load_extension 'fzf'
        end,
        cond = vim.fn.executable 'make' == 1,
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require('telescope').load_extension 'ui-select'
        end,
    },
}
