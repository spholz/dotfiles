local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
    -- Enable completion in buffers with LSP
    -- require'completion'.on_attach()


    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Needed if completion is only enabled for LSP buffers
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {
        noremap = true,
        buffer = true,
        silent = true,
    }

    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('v', '<leader>la', vim.lsp.buf.range_code_action, opts)

    -- vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, opts)
    -- vim.keymap.set('v', '<leader>lf', vim.lsp.buf.range_formatting, opts)

    -- vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, opts)
    -- vim.keymap.set({'n', 'v'}, '<leader>lR', vim.lsp.buf.rename, opts)

    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap=true, silent=true })
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true })
end

lspconfig.pyright.setup {
    on_attach = on_attach
}

lspconfig.clangd.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<leader>c<tab>', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true, silent = true })
    end,
    cmd = { "clangd", "--header-insertion=never" }
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

require'lspconfig'.cmake.setup{
    on_attach = on_attach
}
