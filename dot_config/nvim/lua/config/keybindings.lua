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

-- window resizing
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>', opts)
vim.keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>', opts)
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', opts)

-- make <C-l> also clear document highlights
-- default: `nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>`
vim.cmd.nnoremap(
    '<C-l>',
    '<Cmd>nohlsearch<Bar>diffupdate<Bar>call v:lua.vim.lsp.buf.clear_references()<Bar>normal! <C-l><CR>'
)

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

-- Change/Delete/Put without yanking old text
vim.keymap.set({ 'n', 'x' }, '<M-c>', '"_c', opts)
vim.keymap.set({ 'n', 'x' }, '<M-d>', '"_d', opts)
vim.keymap.set({ 'n', 'x' }, '<M-d><M-d>', '"_dd', opts)
vim.keymap.set({ 'n', 'x' }, '<M-p>', '"_dP', opts)

-- System clipboard shortcuts
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y', opts)
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p', opts)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local map = require('util.keymap').map_with_desc

        local lsp_opts = {
            noremap = true,
            buffer = args.buf,
            silent = true,
        }

        local telescope_builtin = require 'telescope.builtin'

        map(
            'n',
            'gd',
            telescope_builtin.lsp_definitions,
            lsp_opts,
            'List LSP references for word under the cursor, jump to reference on `<cr>`'
        )
        map(
            'n',
            'gT',
            telescope_builtin.lsp_type_definitions,
            lsp_opts,
            "Go to the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope"
        )
        map('n', 'gD', vim.lsp.buf.declaration, lsp_opts, 'Go to declaration')
        map(
            'n',
            'gI',
            telescope_builtin.lsp_implementations,
            lsp_opts,
            "Go to the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope"
        )
        map('n', 'gr', telescope_builtin.lsp_references, lsp_opts, 'List all references in Telescope')

        map('i', '<C-s>', vim.lsp.buf.signature_help, lsp_opts, 'Show signature help popup')

        map('n', '<Leader>a', vim.lsp.buf.code_action, lsp_opts, 'Execute a code action')
        map('x', '<Leader>a', vim.lsp.buf.code_action, lsp_opts, 'Execute a code action')

        map('n', '<Leader>f', vim.lsp.buf.format, lsp_opts, 'Format the current buffer')
        map('x', '<Leader>f', vim.lsp.buf.format, lsp_opts, 'Format the current selection')

        map('n', '<Leader>r', vim.lsp.buf.rename, lsp_opts, 'Rename symbol under cursor')

        map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, lsp_opts, 'Add a folder to the workspace')
        map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, lsp_opts, 'Remove a folder from the workspace')
        map('n', '<Leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, lsp_opts, 'List workspace folders')
    end,
    group = vim.api.nvim_create_augroup('lsp_keybindings', {}),
})
