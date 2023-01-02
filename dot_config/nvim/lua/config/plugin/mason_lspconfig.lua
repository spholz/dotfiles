local map_with_desc = require('util.keymap').map_with_desc

local on_attach = function(client, bufnr)
    -- Needed if completion is only enabled for LSP buffers
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {
        noremap = true,
        buffer = bufnr,
        silent = true,
    }

    map_with_desc('n', 'gd', vim.lsp.buf.definition, opts, 'Go to definition')
    -- map_with_desc('n', '', vim.lsp.buf.type_definition, opts, 'Go to type definition')
    map_with_desc('n', 'gD', vim.lsp.buf.declaration, opts, 'Go to declaration')
    -- map_with_desc('n', '', vim.lsp.buf.implementation, opts, 'List all implementations in the quickfix window')
    map_with_desc('n', 'gr', vim.lsp.buf.references, opts, 'List all references in the quickfix window')
    map_with_desc('n', 'K', vim.lsp.buf.hover, opts, 'Display hover information')

    map_with_desc('n', '<Leader>a', vim.lsp.buf.code_action, opts, 'Execute a code action')
    map_with_desc('v', '<Leader>a', vim.lsp.buf.range_code_action, opts, 'Execute a code action')

    map_with_desc('n', '<Leader>f', vim.lsp.buf.format, opts, 'Format the current buffer')
    map_with_desc('x', '<Leader>f', vim.lsp.buf.format, opts, 'Format the current selection')

    map_with_desc('n', '<Leader>r', vim.lsp.buf.rename, opts, 'Rename symbol under cursor')

    map_with_desc('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts, 'Add a folder to the workspace')
    map_with_desc('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts, 'Remove a folder from the workspace')
    map_with_desc('n', '<Leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts, 'List workspace folders')

    local lsp_augroup = vim.api.nvim_create_augroup('lsp', { clear = true })

    if client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.refresh()
        -- vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        --     buffer = bufnr,
        --     callback = vim.lsp.codelens.refresh,
        --     group = lsp_augroup,
        -- })
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.schedule(function()
            vim.api.nvim_create_autocmd({ 'CursorHold' }, {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
                group = lsp_augroup,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
                group = lsp_augroup,
            })
        end)
    end
end

local servers = {
    'clangd',
    'cmake',
    'cssls',
    'html',
    'jdtls',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'taplo', -- toml
    'texlab',
    'zls',
}

local external_servers = {
    ghdl_ls = {}, -- part of pyghdl
    gdscript = {}, -- server integrated into the editor
    qmlls = {
        cmd = { '/usr/lib/qt6/bin/qmlls' },
    },
}

local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = servers,
}

local capabilities = vim.tbl_deep_extend('keep', require('cmp_nvim_lsp').default_capabilities(), {
    workspace = {
        codeLens = {
            refreshSupport = true,
        },
    },
})

mason_lspconfig.setup_handlers {
    ---@comment default handler
    ---@param server_name string
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,

    clangd = function()
        lspconfig.clangd.setup {
            on_attach = function(_, bufnr)
                on_attach(_, bufnr)
                map_with_desc(
                    'n',
                    '<Leader>c<Tab>',
                    vim.cmd.ClangdSwitchSourceHeader,
                    { noremap = true, silent = true, buffer = bufnr },
                    'Switch between source/header'
                )
            end,
            cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' },
            capabilities = vim.tbl_deep_extend('keep', capabilities, { offsetEncoding = 'utf-8' }),
        }
    end,

    denols = function()
        lspconfig.denols.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            single_file_support = true,
        }
    end,

    rust_analyzer = function()
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        command = 'clippy',
                        allTargets = false,
                    },
                },
            },
        }
    end,

    sumneko_lua = function()
        lspconfig.sumneko_lua.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'packer_plugins' },
                    },
                    runtime = {}, -- needed in on_init()
                    workspace = {}, -- needed in on_init()
                },
            },
            on_init = function(client)
                -- set workspace.library to nvim runtime paths if in ~/.config/nvim
                -- slows down startup
                -- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings

                local workspace_path = client.workspace_folders[1].name

                if workspace_path == vim.fn.stdpath 'config' then
                    local nvim_runtime_path = vim.split(package.path, ';')
                    table.insert(nvim_runtime_path, 'lua/?.lua')
                    table.insert(nvim_runtime_path, 'lua/?/init.lua')

                    client.config.settings.Lua.runtime.path = nvim_runtime_path
                    client.config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file('', true)

                    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
                end

                return true
            end,
        }
    end,

    texlab = function()
        lspconfig.texlab.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                texlab = {
                    build = {
                        -- args = { "-c", "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                        onSave = true,
                        -- forwardSearchAfter = true,
                    },
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
    end,
}

for server, config in pairs(external_servers) do
    config = vim.tbl_deep_extend('keep', config, {
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend('keep', require('cmp_nvim_lsp').default_capabilities(), {
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
if not _G.HANDLER_ADDED then
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
        vim.api.nvim_err_writeln 'workspace/codeLens/refresh already implemented! remove it from lspconfig.lua!'
    end
end

-- prevent from running the above code multiple times (e.g. by sourcing it again)
_G.HANDLER_ADDED = true
