require('nvim-treesitter.configs').setup {
    -- ensure_installed = { 'c', 'cpp', 'python', 'rust', 'lua', 'haskell',
    --                      'bash', 'toml', 'json', 'jsonc', 'yaml', 'html',
    --                      'devicetree', 'verilog', 'gdscript', 'regex',
    --                      'rst', 'latex', 'comment', 'query', 'wgsl' },
    ensure_installed = 'all',
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
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
