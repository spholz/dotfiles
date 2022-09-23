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

function _G.quickfixtextfunc(info)
    local items
    if info.quickfix > 0 then
        items = vim.fn.getqflist({ id = info.id, items = 0 }).items
    else
        items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end

    local list = {}

    for i = info.start_idx, info.end_idx do
        local item = items[i]

        local line = ''

        local file_name = ''
        if item.bufnr > 0 then
            file_name = vim.api.nvim_buf_get_name(item.bufnr)
            if file_name == '' then
                file_name = '[No Name]'
            end
        end

        if file_name ~= '' then
            line = line .. file_name

            if item.lnum > 0 then
                line = line .. ':' .. tostring(item.lnum)

                if item.end_lnum > 0 and item.end_lnum ~= item.lnum then
                    line = line .. '-' .. tostring(item.end_lnum)
                end

                if item.col > 0 then
                    line = line .. ':' .. tostring(item.col)

                    if item.end_col > 0 and item.end_col ~= item.col then
                        line = line .. '-' .. tostring(item.end_col)
                    end
                end
            end
        end

        if line ~= '' then
            line = line .. ': '
        end

        table.insert(list, line .. item.text)
    end

    return list
end

vim.opt.quickfixtextfunc = '{info -> v:lua.quickfixtextfunc(info)}'

vim.opt.guifont = 'Fira Code:h14'

vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 800 -- for CursorHold (e.g. for document highlights) and swap file

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank {
            timeout = 250,
        }
    end,
    group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
})

vim.opt.shell = 'fish'
