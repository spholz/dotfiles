local lspconfig = require'lspconfig'

local on_attach = function(_, bufnr)
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

    vim.keymap.set({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
end

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

local servers = {
    pyright = {},
    -- pylsp = {},
    clangd = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            vim.keymap.set('n', '<leader>c<tab>', '<cmd>ClangdSwitchSourceHeader<cr>', { noremap = true, silent = true })
        end,
        cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' }
    },
    -- ccls = {},
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    allTargets = false,
                }
            }
        }
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
}

for server, config in pairs(servers) do
    config = vim.tbl_deep_extend('keep', config, {
        on_attach = on_attach,
    })

    lspconfig[server].setup(config)
end
