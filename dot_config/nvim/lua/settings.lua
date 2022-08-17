vim.opt.hidden = true
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

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.path:append('**')

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.shortmess:append({ c = true }) -- 'c' don't show the "match x of y" message

vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmode = false
-- vim.opt.showtabline = 1 -- 1: only if there are at least two tab pages -- doesn't work with lualine

vim.opt.guifont = 'FiraCode Nerd Font:h24'

vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
