local cmp = require 'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-y>'] = cmp.mapping.confirm { select = true }, -- default is select = false
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer', keyword_length = 5 },
    }),

    formatting = {
        fields = { 'kind', 'abbr', 'menu' }, -- show kind first: 'פּ utils'
        format = require('lspkind').cmp_format {
            mode = 'symbol', -- symbol only ('פּ' instead of symbol_text: 'פּ Struct')
            maxwidth = 50,
            menu = {
                buffer = ' ',
                nvim_lsp = '  ',
                nvim_lua = ' ',
                path = ' ',
                luasnip = ' ',
            },
            -- these symbols will appear larger in kitty as they are always followed by a space character
            symbol_map = {
                Text = '',
                Method = '',
                Function = '', -- 
                Constructor = '',
                Field = '',
                Variable = '',
                Class = '',
                Interface = '',
                Module = '',
                Property = '',
                Unit = '',
                Value = '',
                Enum = '',
                Keyword = '',
                Snippet = '',
                Color = '',
                File = '',
                Reference = '',
                Folder = '',
                EnumMember = '',
                Constant = '',
                Struct = '',
                Event = '',
                Operator = '',
                TypeParameter = '',
            },
        },
    },

    -- view = {
    --     entries = 'native',
    -- },

    -- experimental = {
    --     ghost_text = true,
    -- },
}

cmp.setup.cmdline(':', {
    completion = {
        autocomplete = false,
    },
    mapping = cmp.mapping.preset.cmdline(),
    formatting = {
        fields = { 'abbr' },
    },
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

cmp.setup.cmdline('/', {
    completion = {
        autocomplete = false,
    },
    mapping = cmp.mapping.preset.cmdline(),
    formatting = {
        fields = { 'abbr', 'kind' },
        format = function(entry, vim_item)
            vim_item.kind = '[' .. entry.source.name .. ']'
            return vim_item
        end,
    },
    sources = {
        { name = 'buffer' },
    },
})
