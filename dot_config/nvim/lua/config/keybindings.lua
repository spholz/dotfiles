-- set the leader key
vim.g.mapleader = ' '

local opts = {
    noremap = true,
    silent = true,
}

-- map <leader> to no action
vim.keymap.set('n', '<leader>', '', opts)

-- use ESC to exit insert mode in terminals
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

-- window navigation
vim.keymap.set('n', '<M-h>', '<C-w>h', opts)
vim.keymap.set('n', '<M-j>', '<C-w>j', opts)
vim.keymap.set('n', '<M-k>', '<C-w>k', opts)
vim.keymap.set('n', '<M-l>', '<C-w>l', opts)

-- LEADER KEY SHORTCUTS

-- BUFFERS

vim.keymap.set('n', '<leader><Tab>', '<cmd>bnext<cr>', opts)
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>bNext<cr>', opts)

vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', opts)

-- TABS

vim.keymap.set('n', '<leader>1', '1gt', opts)
vim.keymap.set('n', '<leader>2', '2gt', opts)
vim.keymap.set('n', '<leader>3', '3gt', opts)
vim.keymap.set('n', '<leader>4', '4gt', opts)
vim.keymap.set('n', '<leader>5', '5gt', opts)
vim.keymap.set('n', '<leader>6', '6gt', opts)
vim.keymap.set('n', '<leader>7', '7gt', opts)
vim.keymap.set('n', '<leader>8', '8gt', opts)
vim.keymap.set('n', '<leader>9', '9gt', opts)

vim.keymap.set('n', '<leader>td', '<cmd>tabclose<cr>', opts)

local map_with_desc = require('util.keymap').map_with_desc

local telescope_builtin = require 'telescope.builtin'

map_with_desc('n', '<leader>o', telescope_builtin.oldfiles, opts, 'Telescope: list previously opened files')
map_with_desc('n', '<leader><leader>', telescope_builtin.buffers, opts, 'Telescope: list open buffers')
map_with_desc(
    'n',
    '<leader>/',
    telescope_builtin.current_buffer_fuzzy_find,
    opts,
    'Telescope: fuzzy find in current buffer'
)

map_with_desc('n', '<leader>tt', telescope_builtin.builtin, opts, 'Telescope: list builtin pickers')

map_with_desc(
    'n',
    '<leader>tf',
    telescope_builtin.find_files,
    opts,
    'Telescope: search for files (respecting .gitignore)'
)
map_with_desc('n', '<leader>th', telescope_builtin.help_tags, opts, 'Telescope: search help tags')
map_with_desc('n', '<leader>tg', telescope_builtin.live_grep, opts, 'Telescope: live grep (respecting .gitignore)')
map_with_desc('n', '<leader>ts', telescope_builtin.grep_string, opts, 'Telescope: grep string under cursor')
map_with_desc('n', '<leader>td', telescope_builtin.diagnostics, opts, 'Telescope: list diagnostics')
