vim.o.hidden = true
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.list = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmenu = true
vim.o.path = vim.o.path .. '**'

-- vim.o.completeopt = 'menuone,noinsert,noselect'
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.o.shortmess = vim.o.shortmess .. 'c' -- .. 'I' -- 'c' don't show the "match x of y" message

vim.o.undofile = true

vim.wo.wrap = false

vim.o.termguicolors = true
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.wo.cursorline = true
vim.o.showmode = false
vim.o.showtabline = 2 -- 2: always show

vim.o.guifont = 'FiraCode Nerd Font:h24'

vim.cmd [[language en_US.UTF-8]] -- translations in nvim are broken

vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- global status line
vim.o.laststatus = 3
