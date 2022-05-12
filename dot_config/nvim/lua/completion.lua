local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] =
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },

        ['<C-space>'] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function(_ --[[fallback]])
                if cmp.visible() then
                    if not cmp.confirm { select = true } then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        }
    }),
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    },

    formatting = {
        format = require'lspkind'.cmp_format {
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[nvim]',
                path = '[path]',
                luasnip = '[snip]',
            },
        },
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
}
