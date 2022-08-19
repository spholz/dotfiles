local lspconfig = require'lspconfig'

local on_attach = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Needed if completion is only enabled for LSP buffers
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {
        noremap = true,
        buffer = bufnr,
        silent = true,
    }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>a', vim.lsp.buf.range_code_action, opts)

    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)
    vim.keymap.set('v', '<leader>f', vim.lsp.buf.range_formatting, opts)

    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
    -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap=true, silent=true })
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true })
end

lspconfig.pyright.setup {
    on_attach = on_attach
}

-- lspconfig.pylsp.setup {
--     on_attach = on_attach
-- }

lspconfig.clangd.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<leader>c<tab>', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true, silent = true })
    end,
    cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' }
}

-- lspconfig.ccls.setup {
--     on_attach = on_attach
-- }

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                allTargets = false,
            }
	    }
    }
}

lspconfig.denols.setup {
    on_attach = on_attach
}

lspconfig.java_language_server.setup {
    on_attch = on_attach,
    cmd = { '/usr/bin/java-language-server' },
}

lspconfig.perlls.setup{
    on_attach = on_attach
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}

lspconfig.texlab.setup {
    on_attach = on_attach,
    settings = {
        texlab = {
            chktex = {
                onEdit = true,
                onOpenAndSave = true,
            },
            forwardSearch = {
                executable = 'okular',
                args = { '--unique', 'file:%p#src:%l%f' },
            },
        },
    },
}

-- require'nlua.lsp.nvim'.setup(lspconfig, {
--     on_attach = on_attach,
--     settings = {
--         Lua = {
--             telemetry = {
--                 enable = false
--             }
--         }
--     }
-- })

lspconfig.cmake.setup {
    on_attach = on_attach
}

lspconfig.hls.setup {
    on_attach = on_attach
}

local configs = require'lspconfig.configs'

if not configs.qmlls then
    configs.qmlls = {
        default_config = {
            cmd = { '/usr/lib/qt6/bin/qmlls' };
            filetypes = { 'qml' };
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end;
            settings = {};
        };
    }
end

lspconfig.qmlls.setup {
    on_attach = on_attach,
}
