return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            -- minimal config
            local parsers = {
                'bash',
                'c',
                'cmake',
                'comment',
                'cpp',
                'diff',
                'gitignore',
                'vimdoc', -- broken (bundled since 0.8)
                'html',
                'java',
                'javascript',
                'json',
                'latex',
                'lua', -- (bundled since 0.8)
                'make',
                'markdown',
                'meson',
                'python',
                'regex',
                'rust',
                'toml',
                'vim', -- (bundled since 0.8)
            }

            -- more parsers!!
            vim.list_extend(parsers, {
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
                'glsl',
                'godot_resource',
                'haskell',
                'hlsl',
                'jsdoc',
                'jsonc',
                'llvm',
                'markdown_inline',
                'ninja',
                'nix',
                'org',
                'perl',
                'php',
                'pioasm',
                'qmljs',
                'query',
                'rst',
                'scala',
                'sql',
                'verilog',
                'wgsl',
                'yaml',
                'zig',
            })

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

                highlight = {
                    enable = true,
                    disable = {
                        'vimdoc', -- highlighting of help files seems broken
                    },
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
                            ['@function.outer'] = 'V', -- linewise
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
