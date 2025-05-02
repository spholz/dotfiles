vim.opt.number = true
-- vim.opt.relativenumber = true

-- share registers via shada
-- vim.api.nvim_create_autocmd({ 'TextYankPost', 'FocusLost', 'FocusGained' }, {
--     command = 'rshada | wshada',
--     group = vim.api.nvim_create_augroup('shared_registers', {}),
-- })

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.list = true

-- vim.opt.hlsearch = false -- don't highlight all matches
vim.opt.scrolloff = 8 -- keep at least 8 lines visible around the cursor

vim.g.netrw_banner = false
vim.g.netrw_winsize = 25

-- disable some providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- don't insert comment characters on o/O
-- set by ftplugins, so use an autocommand
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt_local.formatoptions:remove 'o'
    end,
    group = vim.api.nvim_create_augroup('format_options', {}),
})

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.path:append '**'

vim.opt.completeopt = {'menuone', 'noselect', 'popup'}
vim.opt.shortmess:append 'c' -- don't show the "match x of y" message
vim.opt.shortmess:append 'I' -- don't show intro text on startup

vim.opt.undofile = true

vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath 'state' .. '/backup//' -- 2x '/' means save entire original file path

vim.opt.wrap = false
vim.opt.foldlevelstart = 99

vim.opt.mousemoveevent = true

vim.opt.cursorline = true

-- shows command previews in a split as well
-- vim.opt.inccommand = 'split'

-- show cursorline only in active buffer
local cursorline_group = vim.api.nvim_create_augroup('cursor_line', {})
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function()
        vim.opt_local.cursorline = true
    end,
    group = cursorline_group,
})
vim.api.nvim_create_autocmd('WinLeave', {
    callback = function()
        vim.opt_local.cursorline = false
    end,
    group = cursorline_group,
})

-- don't show cursorline in Telescope
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'TelescopePrompt',
    callback = function()
        vim.opt_local.cursorline = false
    end,
    group = cursorline_group,
})

vim.opt.showmode = false
-- vim.opt.showtabline = 1 -- 1: only if there are at least two tab pages -- doesn't work with lualine

vim.opt.guifont = 'Fira Code:h14'

vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100 -- for CursorHold (e.g. for document highlights) and swap file

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
})

vim.opt.diffopt:append 'linematch:50'

vim.opt.shell = 'fish'

vim.opt.spelllang = 'en_us,en,de'

vim.opt.exrc = true

-- there is no filetype 'terminal' so no ftplugin :(
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
    group = vim.api.nvim_create_augroup('terminal_options', {}),
})
