vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd.TSUpdate()
        end
    end
})

vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
})


-- minimal config
local parsers = {
    'bash',
    'cmake',
    'comment',
    'cpp',
    'diff',
    'gitignore',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'make',
    'meson',
    'python',
    'regex',
    'rust',
    'toml',
}

local bundled_parsers = {
    'c',
    'lua',
    'markdown',
    'query',
    'vim',
    'vimdoc',
}

vim.list_extend(parsers, bundled_parsers)

local more_parsers = {
    'asm',
    'bibtex',
    'c_sharp',
    'css',
    'devicetree',
    'dockerfile',
    'fish',
    'gdscript',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitignore',
    'glsl',
    'gn',
    'godot_resource',
    'haskell',
    'kconfig',
    'linkerscript',
    'llvm',
    'markdown_inline',
    'ninja',
    'nix',
    'rst',
    'ssh_config',
    'strace',
    'systemverilog',
    'wgsl',
    'yaml',
    'zig',
}

-- more parsers!!
vim.list_extend(parsers, more_parsers)

require('nvim-treesitter').install(parsers)

local file_types = vim.iter(parsers):map(vim.treesitter.language.get_filetypes):flatten():totable()

vim.api.nvim_create_autocmd('FileType', {
    pattern = file_types,
    callback = function()
        vim.treesitter.start()

        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require('treesitter-context').setup {
    enable = true,
    multiwindow = false,
    max_lines = 0, -- no limit
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 10,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
}
