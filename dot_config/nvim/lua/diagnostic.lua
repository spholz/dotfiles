vim.diagnostic.config {
    underline = true,
    virtual_text = {
        source = 'if_many', -- show diagnostic source if more than one source is in the buffer
    },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
}

local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts) -- replaced with trouble.nvim (plugins.lua)
