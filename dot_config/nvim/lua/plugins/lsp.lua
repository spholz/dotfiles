return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'nvim-cmp',
        },
        config = function()
            local lsp_augroup = vim.api.nvim_create_augroup('lsp', {})

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if client == nil or not client.server_capabilities.documentHighlightProvider then
                        return
                    end

                    vim.api.nvim_create_autocmd('CursorHold', {
                        buffer = args.buf,
                        callback = vim.lsp.buf.document_highlight,
                        group = lsp_augroup,
                    })

                    vim.api.nvim_create_autocmd('CursorMoved', {
                        buffer = args.buf,
                        callback = vim.lsp.buf.clear_references,
                        group = lsp_augroup,
                    })
                end,
                group = lsp_augroup,
            })
            local map = require('util.keymap').map_with_desc
            map(
                'n',
                '<Leader>c',
                vim.cmd.ClangdSwitchSourceHeader,
                { noremap = true, silent = true },
                'Switch between source/header'
            )

            local servers = {
                'clangd',
                'pyright',
                'rust_analyzer',
                'lua_ls',
                'taplo', -- toml
                'texlab',
                'zls',
            }

            local external_servers = {
                gdscript = {}, -- server integrated into the editor
                qmlls = {
                    cmd = { '/usr/lib/qt6/bin/qmlls' },
                },
                hls = {},
            }

            local lspconfig = require 'lspconfig'
            local mason_lspconfig = require 'mason-lspconfig'

            require('mason').setup()

            mason_lspconfig.setup {
                ensure_installed = servers,
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason_lspconfig.setup_handlers {
                ---@comment default handler
                ---@param server_name string
                function(server_name)
                    lspconfig[server_name].setup {
                        capabilities = capabilities,
                    }
                end,

                clangd = function()
                    lspconfig.clangd.setup {
                        cmd = { 'clangd', '--header-insertion=iwyu', '--clang-tidy' },
                        capabilities = vim.tbl_deep_extend('keep', capabilities, { offsetEncoding = 'utf-8' }),
                    }
                end,

                rust_analyzer = function()
                    lspconfig.rust_analyzer.setup {
                        capabilities = capabilities,
                        settings = {
                            ['rust-analyzer'] = {
                                checkOnSave = {
                                    command = 'clippy',
                                    allTargets = false,
                                },
                                assist = {
                                    emitMustUse = true,
                                    expressionFillDefault = 'default',
                                },
                            },
                        },
                    }
                end,

                lua_ls = function()
                    lspconfig.lua_ls.setup {
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

                            if client.workspace_folders == nil then
                                return
                            end

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
                        capabilities = capabilities,
                        settings = {
                            texlab = {
                                build = {
                                    executable = 'tectonic',
                                    args = { '-X', 'compile', '%f', '--synctex', '--keep-logs', '--keep-intermediates' },
                                    onSave = true,
                                    forwardSearchAfter = true,
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

                zls = function()
                    lspconfig.zls.setup {
                        settings = {
                            zls = {
                                zig_exe_path = vim.fn.exepath 'zig',
                            },
                        },
                    }
                end,
            }

            for server, config in pairs(external_servers) do
                config = vim.tbl_deep_extend('keep', config, {
                    capabilities = capabilities,
                })

                lspconfig[server].setup(config)
            end
        end,
    },
}
