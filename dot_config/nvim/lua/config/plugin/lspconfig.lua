local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
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

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    local lsp_augroup = vim.api.nvim_create_augroup('LspCodeLens', { clear = true })

    if client.resolved_capabilities.code_lens then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
            group = lsp_augroup,
        })
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
            group = lsp_augroup,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
            group = lsp_augroup,
        })
    end
end

local lsp_status_ok, lsp_status = pcall(require, 'lsp-status')
if lsp_status_ok then
    lsp_status.register_progress() -- for lualine lsp progress indicator
end

local configs = require 'lspconfig.configs'

if not configs.qmlls then
    configs.qmlls = {
        default_config = {
            cmd = { '/usr/lib/qt6/bin/qmlls' },
            filetypes = { 'qml' },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {},
        },
    }
end

local servers = {
    pyright = {},
    -- pylsp = {},
    clangd = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            vim.keymap.set(
                'n',
                '<leader>c<tab>',
                '<cmd>ClangdSwitchSourceHeader<cr>',
                { noremap = true, silent = true }
            )
        end,
        cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' },
    },
    -- ccls = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy',
                    allTargets = false,
                },
            },
        },
    },
    denols = {},
    java_language_server = {
        cmd = { '/usr/bin/java-language-server' },
    },
    perlls = {},
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
    texlab = {
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
    },
    cmake = {},
    hls = {},
    qmlls = {},
    taplo = {},
}

for server, config in pairs(servers) do
    config = vim.tbl_deep_extend('keep', config, {
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(), {
            workspace = {
                codeLens = {
                    refreshSupport = true,
                },
            },
        }),
    })

    lspconfig[server].setup(config)
end

-- add workspace/codeLens/refresh handler
if not HANDLER_ADDED then
    if not vim.lsp.handlers['workspace/codeLens/refresh'] then
        vim.lsp.handlers['workspace/codeLens/refresh'] = function(err, _, ctx, _)
            if not err then
                for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
                    vim.lsp.buf_request(bufnr, 'textDocument/codeLens', {
                        textDocument = vim.lsp.util.make_text_document_params(bufnr),
                    }, vim.lsp.codelens.on_codelens)
                end
            end

            return vim.NIL
        end
    else
        vim.api.nvim_err_writeln 'workspace/codeLens/refresh already implemented! remove implementation in lspconfig.lua!'
    end
end

-- prevent from running the above code multiple times (e.g. by sourcing it again)
HANDLER_ADDED = true
