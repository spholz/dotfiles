return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp_augroup = vim.api.nvim_create_augroup('lsp', {})

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                    if client.server_capabilities.documentHighlightProvider then
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
                    end

                    if client:supports_method('textDocument/completion') then
                        vim.keymap.set('i', '<c-space>', function()
                            vim.lsp.completion.get()
                        end)

                        -- trigger autocompletion on EVERY keypress
                        local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                        client.server_capabilities.completionProvider.triggerCharacters = chars

                        vim.lsp.completion.enable(true, client.id, args.buf, {
                            autotrigger = true,
                        })
                    end
                end,
                group = lsp_augroup,
            })
            local map = require('util.keymap').map_with_desc
            map(
                'n',
                '<Leader>c',
                vim.cmd.LspClangdSwitchSourceHeader,
                { noremap = true, silent = true },
                'Switch between source/header'
            )

            local capabilities = {}

            local servers = {
                clangd = {
                    cmd = { 'clangd', '--clang-tidy' },
                },
                pyright = {},
                rust_analyzer = {
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
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim', 'packer_plugins' },
                            },
                            runtime = {},   -- needed in on_init()
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
                },
                taplo = {}, -- toml
                texlab = {
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
                },
                zls = {
                    settings = {
                        zls = {
                            zig_exe_path = vim.fn.exepath 'zig',
                        },
                    },
                },
                gdscript = {}, -- server integrated into the editor
                qmlls = {
                    cmd = { '/usr/lib/qt6/bin/qmlls' },
                },
            }

            for server, config in pairs(servers) do
                config = vim.tbl_deep_extend('keep', config, {
                    capabilities = capabilities,
                })

                vim.lsp.config[server] = config
                vim.lsp.enable(server)
            end
        end,
    },
}
