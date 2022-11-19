-- set the leader key
vim.g.mapleader = ' '

local opts = {
    noremap = true,
    silent = true,
}

-- map <Leader> to no action
vim.keymap.set('n', '<Leader>', '', opts)

-- use ESC to exit insert mode in terminals
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

-- window navigation
vim.keymap.set('n', '<M-h>', '<C-w>h', opts)
vim.keymap.set('n', '<M-j>', '<C-w>j', opts)
vim.keymap.set('n', '<M-k>', '<C-w>k', opts)
vim.keymap.set('n', '<M-l>', '<C-w>l', opts)

-- Leader key shortcuts {{{

-- Buffers

vim.keymap.set('n', '<Leader><Tab>', '<Cmd>bnext<CR>', opts)
vim.keymap.set('n', '<Leader><S-Tab>', '<Cmd>bNext<CR>', opts)

vim.keymap.set('n', '<Leader>bd', '<Cmd>bdelete<CR>', opts)

-- Tabs

vim.keymap.set('n', '<Leader>1', '1gt', opts)
vim.keymap.set('n', '<Leader>2', '2gt', opts)
vim.keymap.set('n', '<Leader>3', '3gt', opts)
vim.keymap.set('n', '<Leader>4', '4gt', opts)
vim.keymap.set('n', '<Leader>5', '5gt', opts)
vim.keymap.set('n', '<Leader>6', '6gt', opts)
vim.keymap.set('n', '<Leader>7', '7gt', opts)
vim.keymap.set('n', '<Leader>8', '8gt', opts)
vim.keymap.set('n', '<Leader>9', '9gt', opts)

vim.keymap.set('n', '<Leader>td', '<Cmd>tabclose<CR>', opts)

-- Telescope

local map_with_desc = require('util.keymap').map_with_desc

local telescope_builtin_ok, telescope_builtin = pcall(require, 'telescope.builtin')
if telescope_builtin_ok then
    map_with_desc('n', '<Leader>o', telescope_builtin.oldfiles, opts, 'Telescope: list previously opened files')
    map_with_desc('n', '<Leader><Leader>', telescope_builtin.buffers, opts, 'Telescope: list open buffers')
    map_with_desc(
        'n',
        '<Leader>/',
        telescope_builtin.current_buffer_fuzzy_find,
        opts,
        'Telescope: fuzzy find in current buffer'
    )

    map_with_desc('n', '<Leader>tt', telescope_builtin.builtin, opts, 'Telescope: list builtin pickers')

    map_with_desc(
        'n',
        '<Leader>tf',
        telescope_builtin.find_files,
        opts,
        'Telescope: search for files (respecting .gitignore)'
    )
    map_with_desc('n', '<Leader>th', telescope_builtin.help_tags, opts, 'Telescope: search help tags')
    map_with_desc('n', '<Leader>tg', telescope_builtin.live_grep, opts, 'Telescope: live grep (respecting .gitignore)')
    map_with_desc('n', '<Leader>ts', telescope_builtin.grep_string, opts, 'Telescope: grep string under cursor')
    map_with_desc('n', '<Leader>td', telescope_builtin.diagnostics, opts, 'Telescope: list diagnostics')
end

-- Put in visual mode without yanking old text

vim.keymap.set('x', '<Leader>p', '"_dP', opts)

map_with_desc('n', '<Leader>p', function()
    require('nvim-pdf').open_doc '/home/s/src/pdfview/test.pdf'
end, opts, 'Open Test PDF')

-- }}}

-- vim: foldmethod=marker
