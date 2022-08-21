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
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
