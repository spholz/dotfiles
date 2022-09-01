-- minimal config
local parsers = {
    'bash',
    'c',
    'cmake',
    'comment',
    'cpp',
    'gitignore',
    -- 'help', -- broken
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'meson',
    'markdown',
    'python',
    'regex',
    'rust',
    'toml',
    'vim',
}

-- more parsers!!
vim.list_extend(parsers, {
    'bibtex',
    'c_sharp',
    'css',
    'devicetree',
    'dockerfile',
    'fish',
    'godot_resource',
    'gdscript',
    'glsl',
    'haskell',
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
    highlight = {
        enable = true,
        disable = {
            'help', -- highlighting of help files seems broken
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
                ['@class.outer'] = '<c-v>', -- blockwise
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
vim.opt.foldlevelstart = 99
