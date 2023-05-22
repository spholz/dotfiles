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

-- make <C-l> also clear document highlights
-- default: `nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>`
vim.cmd [[nnoremap <C-l> <Cmd>nohlsearch<Bar>diffupdate<Bar>call v:lua.vim.lsp.buf.clear_references()<Bar>normal! <C-l><CR>]]

-- Leader key shortcuts {{{

-- Buffers

vim.keymap.set('n', '<Leader><Tab>', vim.cmd.bnext, opts)
vim.keymap.set('n', '<Leader><S-Tab>', vim.cmd.bNext, opts)

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

-- Put in visual mode without yanking old text
vim.keymap.set('x', '<Leader>p', '"_dP', opts)

-- }}}

-- vim: foldmethod=marker
