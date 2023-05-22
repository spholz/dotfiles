return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'nvim-cmp',
        },
        config = function()
            require 'config.plugin.mason_lspconfig'
        end,
    },

    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require 'null-ls'
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.autoflake,
                    null_ls.builtins.formatting.blue,
                    null_ls.builtins.formatting.reorder_python_imports,
                    null_ls.builtins.diagnostics.cppcheck,
                    null_ls.builtins.diagnostics.fish,
                    null_ls.builtins.diagnostics.gitlint,
                    null_ls.builtins.diagnostics.glslc,
                    -- null_ls.builtins.diagnostics.markdownlint,
                    -- null_ls.builtins.diagnostics.mypy,
                    -- null_ls.builtins.diagnostics.pylint,
                    null_ls.builtins.diagnostics.qmllint,
                    null_ls.builtins.diagnostics.rstcheck,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.diagnostics.zsh,
                    -- null_ls.builtins.diagnostics.trail_space,
                },
            }
        end,
    },
}
