vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.list = true

-- don't insert comment symbols on o/O
-- set by ftplugins, so use an autocommand
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt_local.formatoptions:remove 'o'
    end,
    group = vim.api.nvim_create_augroup('FormatOptions', { clear = true }),
})

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.path:append '**'

vim.opt.shortmess:append 'c' -- 'c' don't show the "match x of y" message

vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.cursorline = true

-- show cursorline only in active buffer
local cursorline_group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
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

vim.opt.guifont = 'FiraCode Nerd Font:h18'

vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 800 -- for CursorHold (e.g. for document highlights) and swap file
