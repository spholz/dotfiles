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

            local map = require('util.keymap').map_with_desc
            local telescope_builtin = require 'telescope.builtin'

            local opts = {
                noremap = true,
                silent = true,
            }

            map('n', '<Leader>R', telescope_builtin.oldfiles, opts, 'Telescope: list previously opened files')
            map('n', '<Leader><Leader>', telescope_builtin.buffers, opts, 'Telescope: list open buffers')
            map(
                'n',
                '<Leader>/',
                telescope_builtin.current_buffer_fuzzy_find,
                opts,
                'Telescope: fuzzy find in current buffer'
            )

            map('n', '<Leader>t', telescope_builtin.builtin, opts, 'Telescope: list builtin pickers')

            map(
                'n',
                '<Leader>o',
                telescope_builtin.find_files,
                opts,
                'Telescope: search for files (respecting .gitignore)'
            )
            map('n', '<Leader>h', telescope_builtin.help_tags, opts, 'Telescope: search help tags')
            map(
                'n',
                '<Leader>j',
                telescope_builtin.lsp_dynamic_workspace_symbols,
                opts,
                'Telescope: list workspace symbols'
            )
            map('n', '<Leader>g', telescope_builtin.live_grep, opts, 'Telescope: live grep (respecting .gitignore)')
            map('n', '<Leader>s', telescope_builtin.grep_string, opts, 'Telescope: grep string under cursor')
            map('n', '<Leader>q', telescope_builtin.diagnostics, opts, 'Telescope: list diagnostics')
            map('n', '<Leader>:', telescope_builtin.command_history, opts, 'Telescope: show command history')
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
