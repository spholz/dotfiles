local lsp_augroup = vim.api.nvim_create_augroup('lsp', {})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd('CursorHold', {
                buffer = args.buf,
                callback = function(ev)
                    -- LSPs usually don't work for fugitive buffers
                    if not vim.startswith(ev.file, 'fugitive://') then
                        vim.lsp.buf.document_highlight()
                    end
                end,
                group = lsp_augroup,
            })

            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = args.buf,
                callback = vim.lsp.buf.clear_references,
                group = lsp_augroup,
            })
        end

        if client:supports_method 'textDocument/completion' then
            vim.keymap.set('i', '<c-space>', function()
                vim.lsp.completion.get()
            end)

            -- trigger autocompletion on EVERY keypress
            local chars = {}
            for i = 32, 126 do
                table.insert(chars, string.char(i))
            end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true,
            })
        end
    end,
    group = lsp_augroup,
})

vim.keymap.set('n', '<Leader>c', vim.cmd.LspClangdSwitchSourceHeader, { desc = 'Switch between source/header' })

local servers = {
    clangd = {
        cmd = { 'clangd', '--clang-tidy' },
    },
    pyright = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                assist = {
                    emitMustUse = true,
                    expressionFillDefault = 'default',
                },
            },
        },
    },
    lua_ls = {},
    taplo = {}, -- toml
    texlab = {
        settings = {
            texlab = {
                build = {
                    -- executable = 'tectonic',
                    -- args = { '-X', 'compile', '%f', '--synctex', '--keep-logs', '--keep-intermediates' },
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
    gdscript = {},
    qmlls = {
        cmd = { '/usr/lib/qt6/bin/qmlls' },
    },
}

for server, config in pairs(servers) do
    if next(config) ~= nil then
        -- vim.lsp.config(server, config)
    end
    vim.lsp.enable(server)
end
