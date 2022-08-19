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

-- don't make 'Special' italic
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local colorscheme = vim.fn.expand '<amatch>'

        if colorscheme == 'molokai' then
            local old_hl = vim.api.nvim_get_hl_by_name('Special', true)
            vim.api.nvim_set_hl(0, 'Special', {
                fg = old_hl.foreground,
                bg = old_hl.background,
                -- no italic
            })
        end
    end,
    group = vim.api.nvim_create_augroup('ColorSchemeFixSpecial', { clear = true }),
})
