vim.opt.laststatus = 3 -- global status line

Statusline = {}

function Statusline.filetype()
    return vim.opt.filetype:get()
end

function Statusline.mode()
    local mode = vim.fn.mode()
    local mode_names = {
        ['n'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['V'] = 'VISUAL LINE',
        [''] = 'VISUAL BLOCK',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT LINE',
        [''] = 'SELECT BLOCK',
        ['i'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['c'] = 'COMMAND',
        ['r'] = 'MORE',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }
    return mode_names[string.sub(mode, 1, 1)]
end

vim.opt.statusline = '%<%2* %{v:lua.Statusline.mode()} %5*%* %f %w%m%r%=%{v:lua.Statusline.filetype()} %3*%4* %P %1*%2* %(%3.l:%-3.c%)'
vim.opt.showmode = false
