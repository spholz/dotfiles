-- set the leader key
vim.g.mapleader = ' '

local opts = {
    noremap = true,
}

-- map <leader> to no action
vim.keymap.set('n', '<leader>', '', opts)

-- -- Smart Tab
-- map('i', '<Tab>', '<Plug>(completion_smart_tab)', {})
-- map('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)', {})
--
-- -- Use C-Space to trigger completion
-- map('i', '<C-Space>', '<Plug>(completion_trigger)', {silent = true})
--
-- -- Use C-j and C-k to navigate popup menus
-- map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', {expr = true, noremap = true})
-- map('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"', {expr = true, noremap = true})
-- -- map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', {expr = true, noremap = true})
-- -- map('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"', {expr = true, noremap = true})

-- use ESC to exit insert mode in terminals
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)

-- window navigation
vim.keymap.set('n', '<M-h>', '<C-w>h', opts)
vim.keymap.set('n', '<M-j>', '<C-w>j', opts)
vim.keymap.set('n', '<M-k>', '<C-w>k', opts)
vim.keymap.set('n', '<M-l>', '<C-w>l', opts)


-- LEADER KEY SHORTCUTS

-- BUFFERS

local silent_opts = {
    silent = true,
    noremap = true,
}

vim.keymap.set('n', '<leader><Tab>', '<cmd>bnext<cr>', silent_opts)
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>bNext<cr>', silent_opts)

vim.keymap.set('n', '<leader>bd', '<cmd>bprevious|bdelete #<cr>', silent_opts)


-- TABS

vim.keymap.set('n', '<leader>1', '1gt', silent_opts)
vim.keymap.set('n', '<leader>2', '2gt', silent_opts)
vim.keymap.set('n', '<leader>3', '3gt', silent_opts)
vim.keymap.set('n', '<leader>4', '4gt', silent_opts)
vim.keymap.set('n', '<leader>5', '5gt', silent_opts)
vim.keymap.set('n', '<leader>6', '6gt', silent_opts)
vim.keymap.set('n', '<leader>7', '7gt', silent_opts)
vim.keymap.set('n', '<leader>8', '8gt', silent_opts)
vim.keymap.set('n', '<leader>9', '9gt', silent_opts)

-- vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<cr>', silent_opts)
-- vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabprevios<cr>', silent_opts)
vim.keymap.set('n', '<leader>td', '<cmd>tabclose<cr>', silent_opts)
vim.keymap.set('n', '<leader>t<Tab>', '<cmd>tabnext<cr>', silent_opts)
vim.keymap.set('n', '<leader>t<S-Tab>', '<cmd>tabprevious<cr>', silent_opts)
