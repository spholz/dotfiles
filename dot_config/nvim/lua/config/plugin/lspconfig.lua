local lspconfig = require 'lspconfig'

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
    map_with_desc('n', 'gt', vim.lsp.buf.type_definition, opts, 'Go to type definition')
    map_with_desc('n', 'gD', vim.lsp.buf.declaration, opts, 'Go to declaration')
    map_with_desc('n', 'gi', vim.lsp.buf.implementation, opts, 'List all implementations in the quickfix window')
    map_with_desc('n', 'gr', vim.lsp.buf.references, opts, 'List all references in the quickfix window')
    map_with_desc('n', 'K', vim.lsp.buf.hover, opts, 'Display hover information')

    map_with_desc('n', '<leader>a', vim.lsp.buf.code_action, opts, 'Execute a code action')
    map_with_desc('v', '<leader>a', vim.lsp.buf.range_code_action, opts, 'Execute a code action')

    map_with_desc('n', '<leader>f', vim.lsp.buf.formatting, opts, 'Format the current buffer')
    map_with_desc('v', '<leader>f', vim.lsp.buf.range_formatting, opts, 'Format the current selection')

    map_with_desc('n', '<leader>r', vim.lsp.buf.rename, opts, 'Rename symbol under cursor')

    map_with_desc('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts, 'Add a folder to the workspace')
    map_with_desc('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts, 'Remove a folder from the workspace')
    map_with_desc('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts, 'List workspace folders')

    -- local lsp_augroup = vim.api.nvim_create_augroup('LspCodeLens', { clear = true })

    if client.resolved_capabilities.code_lens then
        vim.lsp.codelens.refresh()
        -- vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        --     buffer = bufnr,
        --     callback = vim.lsp.codelens.refresh,
        --     group = lsp_augroup,
        -- })
    end

    -- if client.resolved_capabilities.document_highlight then
    --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --         buffer = bufnr,
    --         callback = vim.lsp.buf.document_highlight,
    --         group = lsp_augroup,
    --     })

    --     vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
    --         buffer = bufnr,
    --         callback = vim.lsp.buf.clear_references,
    --         group = lsp_augroup,
    --     })
    -- end
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
    -- asm_lsp = {},
    -- bashls = {},
    -- ccls = {},
    clangd = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            map_with_desc(
                'n',
                '<leader>c<tab>',
                '<cmd>ClangdSwitchSourceHeader<cr>',
                { noremap = true, silent = true, buffer = bufnr },
                'Switch between source/header'
            )
        end,
        cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' },
    },
    cmake = {},
    -- csharp_ls = {},
    cssls = {
        cmd = { 'vscode-css-languageserver', '--stdio' },
    },
    denols = {},
    -- diagnosticls = {},
    -- dockerls = {},
    -- dotls = {}, -- graphviz dot
    -- esbonio = {}, -- sphinx (rst)
    -- eslint = {},
    gdscript = {}, -- server integrated into the editor
    -- hls = {}, -- haskell
    ghdl_ls = {}, -- part of pyghdl
    -- glslls = {}, -- replaced with null-ls glslc
    -- gradle_ls = {},
    -- grammarly = {}, wtf?
    -- hdl_checker = {}, -- for vhdl, verilog, systemverilog
    html = {
        cmd = { 'vscode-html-languageserver', '--stdio' },
    },
    -- java_language_server = {
    --     cmd = { 'java-language-server' },
    -- },
    -- jedi_language_server = {}, -- python
    jsonls = {
        cmd = { 'vscode-json-languageserver', '--stdio' },
    },
    -- lemminx = {}, -- xml
    -- ltex = {}, -- also for md, rst, org, bibtex, org
    -- marksman = {}, -- markdown
    -- metals = {}, -- scala
    -- nil_ls = {}, -- nix expressions
    -- omnisharp = {},
    -- opencl_ls = {},
    -- perlls = {},
    -- perlpls = {},
    -- powershell_es = {},
    -- prosemd_lsp = {}, -- markdown
    -- pylsp = {},
    -- pyre = {},
    pyright = {},
    qmlls = {},
    -- qml_lsp = {},
    -- quick_lint_js = {},
    -- racket_langserver = {},
    -- rnix = {}, -- nix expressions
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
    -- sourcery = {}, -- python ai refactor thingy
    -- sqlls = {},
    -- sqls = {},
    -- stylelint_lsp = {},
    sumneko_lua = {
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
    },
    -- svlangserver = {}, -- systemverilog
    taplo = {}, -- toml
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
    -- tsserver = {}, -- typescript
    -- verible = {}, -- linter for verilog, systemverilog
    -- veridian = {}, -- systemveriloh
    -- vimls = {},
    -- wgsl_analyzer = {},
    -- yamlls = {},
}

for server, config in pairs(servers) do
    config = vim.tbl_deep_extend('keep', config, {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(), {
                workspace = {
                    codeLens = {
                        refreshSupport = true,
                    },
                },
            })
        ),
    })

    -- TODO: maybe only setup servers not already setup
    --       (BufWritePost is set to packer.compile() in all nvim config files)
    --       as this causes sumneko_lua to reindex all files
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
