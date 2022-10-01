local map_with_desc = require('util.keymap').map_with_desc

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

map_with_desc('n', '<Leader>e', vim.diagnostic.open_float, opts, 'Show diagnostics in a floating window')
map_with_desc('n', '[d', vim.diagnostic.goto_prev, opts, 'Move to previous diagnostic')
map_with_desc('n', ']d', vim.diagnostic.goto_next, opts, 'Move to next diagnostic')

-- replaced with trouble.nvim (plugins.lua)
-- map_with_desc('n', '<Leader>q', vim.diagnostic.setloclist, opts, 'Add buffer diagnostics to the location list')
