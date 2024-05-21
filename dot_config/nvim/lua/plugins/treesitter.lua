return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            -- minimal config
            local parsers = {
                'bash',
                'cmake',
                'comment',
                'cpp',
                'diff',
                'gitignore',
                'html',
                'java',
                'javascript',
                'json',
                'latex',
                'make',
                'markdown',
                'meson',
                'python',
                'regex',
                'rust',
                'toml',
            }

            local bundled_parsers = {
                'c',
                'lua',
                'query',
                'vim',
                'vimdoc',
            }

            vim.list_extend(parsers, bundled_parsers)

            local more_parsers = {
                'asm',
                'bibtex',
                'c_sharp',
                'css',
                'devicetree',
                'dockerfile',
                'fish',
                'gdscript',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitignore',
                'glsl',
                'gn',
                'godot_resource',
                'haskell',
                'kconfig',
                'linkerscript',
                'llvm',
                'markdown_inline',
                'ninja',
                'nix',
                'rst',
                'ssh_config',
                'strace',
                'verilog',
                'wgsl',
                'yaml',
                'zig',
            }

            -- more parsers!!
            vim.list_extend(parsers, more_parsers)

            -- remove all parsers that require tree-sitter CLI if it isn't installed
            if vim.fn.executable 'tree-sitter' == 0 then
                local parser_defs = require('nvim-treesitter.parsers').list

                for i, parser in ipairs(parsers) do
                    if parser_defs[parser].install_info.requires_generate_from_grammar then
                        parsers[i] = nil
                    end
                end
            end

            require('nvim-treesitter.configs').setup {
                ensure_installed = parsers,
                auto_install = true,

                modules = {},
                ignore_install = {},
                sync_install = false,

                highlight = {
                    enable = true,
                    disable = {},
                },
                incremental_selection = {
                    enable = true,
                },
                -- indent = {
                --     enable = true
                -- },

                -- nvim-treesitter-textobjects
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<A-n>'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<A-p>'] = '@parameter.inner',
                        },
                    },
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<C-v>', -- blockwise
                        },

                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding xor succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        include_surrounding_whitespace = true,
                    },
                },
            }

            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
        dependencies = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
        },
    },
}
