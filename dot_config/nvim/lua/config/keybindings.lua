-- set the leader key
vim.g.mapleader = ' '

-- map <Leader> to no action
vim.keymap.set('n', '<Leader>', '')

-- use ESC to exit insert mode in terminals
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- window navigation
vim.keymap.set('n', '<M-h>', '<C-w>h')
vim.keymap.set('n', '<M-j>', '<C-w>j')
vim.keymap.set('n', '<M-k>', '<C-w>k')
vim.keymap.set('n', '<M-l>', '<C-w>l')

-- window resizing
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')

-- make square bracket commands (easily) usable on german keyboards
vim.keymap.set('n', 'ö', '[', { remap = true })
vim.keymap.set('n', 'ä', ']', { remap = true })

-- make <C-l> also clear document highlights
-- default: `nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>`
vim.cmd.nnoremap(
    '<C-l>',
    '<Cmd>nohlsearch<Bar>diffupdate<Bar>call v:lua.vim.lsp.buf.clear_references()<Bar>normal! <C-l><CR>'
)

-- Buffers

vim.keymap.set('n', '<Leader><Tab>', vim.cmd.bnext)
vim.keymap.set('n', '<Leader><S-Tab>', vim.cmd.bNext)

-- Tabs

vim.keymap.set('n', '<Leader>1', '1gt')
vim.keymap.set('n', '<Leader>2', '2gt')
vim.keymap.set('n', '<Leader>3', '3gt')
vim.keymap.set('n', '<Leader>4', '4gt')
vim.keymap.set('n', '<Leader>5', '5gt')
vim.keymap.set('n', '<Leader>6', '6gt')
vim.keymap.set('n', '<Leader>7', '7gt')
vim.keymap.set('n', '<Leader>8', '8gt')
vim.keymap.set('n', '<Leader>9', '9gt')

-- System clipboard shortcuts
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local telescope_builtin = require 'telescope.builtin'

        local function map_local(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
        end

        map_local(
            'n',
            'gd',
            telescope_builtin.lsp_definitions,
            'List LSP references for word under the cursor, jump to reference on `<cr>`'
        )

        map_local(
            'n',
            'gT',
            telescope_builtin.lsp_type_definitions,
            "Go to the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope"
        )

        map_local(
            'n',
            'gD',
            vim.lsp.buf.declaration,
            'Go to declaration'
        )

        map_local(
            'n',
            'gI',
            telescope_builtin.lsp_implementations,
            "Go to the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope"
        )

        map_local(
            'n',
            'gr',
            telescope_builtin.lsp_references,
            'List all references in Telescope'
        )

        map_local(
            'n',
            '<Leader>j',
            telescope_builtin.lsp_dynamic_workspace_symbols,
            'List workspace symbols'
        )

        map_local(
            'n',
            '<Leader>a',
            vim.lsp.buf.code_action,
            'Execute a code action'
        )

        map_local(
            'x',
            '<Leader>a',
            vim.lsp.buf.code_action,
            'Execute a code action'
        )

        map_local(
            'n',
            '<Leader>f',
            vim.lsp.buf.format,
            'Format the current buffer'
        )

        map_local(
            'x',
            '<Leader>f',
            vim.lsp.buf.format,
            'Format the current selection'
        )

        map_local(
            'n',
            '<Leader>r',
            vim.lsp.buf.rename,
            'Rename symbol under cursor'
        )

        map_local(
            'n',
            '<Leader>wa',
            vim.lsp.buf.add_workspace_folder,
            'Add a folder to the workspace'
        )

        map_local(
            'n',
            '<Leader>wr',
            vim.lsp.buf.remove_workspace_folder,
            'Remove a folder from the workspace'
        )

        map_local(
            'n',
            '<Leader>wl',
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            'List workspace folders'
        )
    end,
    group = vim.api.nvim_create_augroup('lsp_keybindings', {}),
})
