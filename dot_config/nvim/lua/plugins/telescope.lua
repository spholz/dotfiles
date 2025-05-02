return {
    { 'nvim-lua/plenary.nvim', lazy = true },
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
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            local telescope_builtin = require 'telescope.builtin'

            vim.keymap.set(
                'n',
                '<Leader>R',
                telescope_builtin.oldfiles,
                { desc = 'Telescope: list previously opened files' }
            )

            vim.keymap.set(
                'n',
                '<Leader><Leader>',
                telescope_builtin.buffers,
                { desc = 'Telescope: list open buffers' }
            )

            vim.keymap.set(
                'n',
                '<Leader>/',
                telescope_builtin.current_buffer_fuzzy_find,
                { desc = 'Telescope: fuzzy find in current buffer' }
            )

            vim.keymap.set(
                'n',
                '<Leader>t',
                telescope_builtin.builtin,
                { desc = 'Telescope: list builtin pickers' }
            )

            vim.keymap.set(
                'n',
                '<Leader>o',
                telescope_builtin.find_files,
                { desc = 'Telescope: search for files (respecting .gitignore)' }
            )

            vim.keymap.set(
                'n',
                '<Leader>h',
                telescope_builtin.help_tags,
                { desc = 'Telescope: search help tags' }
            )

            vim.keymap.set(
                'n',
                '<Leader>g',
                telescope_builtin.live_grep,
                { desc = 'Telescope: live grep (respecting .gitignore)' }
            )

            vim.keymap.set(
                'n',
                '<Leader>s',
                telescope_builtin.grep_string,
                { desc = 'Telescope: grep string under cursor' }
            )

            vim.keymap.set(
                'n',
                '<Leader>q',
                telescope_builtin.diagnostics,
                { desc = 'Telescope: list diagnostics' }
            )

            vim.keymap.set(
                'n',
                '<Leader>:',
                telescope_builtin.command_history,
                { desc = 'Telescope: show command history' }
            )
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
