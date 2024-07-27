return {
    'hrsh7th/nvim-cmp',
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load()

        local cmp = require 'cmp'

        local lsp_icons = {
            Class = '',
            Color = '',
            Constant = '',
            Constructor = '',
            Enum = '',
            EnumMember = '',
            Event = '',
            Field = '',
            File = '',
            Folder = '',
            Function = '',
            Interface = '',
            Keyword = '',
            Method = '',
            Module = '',
            Operator = '',
            Property = '',
            Reference = '',
            Snippet = '',
            Struct = '',
            Text = '',
            TypeParameter = '',
            Unit = '',
            Value = '',
            Variable = '',
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help' },
            }, {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer', keyword_length = 5 },
            }),

            formatting = {
                fields = { 'kind', 'abbr', 'menu' },

                ---@param entry cmp.Entry
                ---@param vim_item vim.CompletedItem
                ---@return vim.CompletedItem
                format = function(entry, vim_item)
                    vim_item.kind = lsp_icons[vim_item.kind] or vim_item.kind
                    vim_item.menu = ({
                        buffer = ' ',
                        nvim_lsp = '  ',
                        nvim_lua = ' ',
                        path = ' ',
                        luasnip = '  ',
                        -- luasnip = ' ',
                    })[entry.source.name]

                    return vim_item
                end,
            },
        }
    end,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = { 'L3MON4D3/LuaSnip', dependencies = 'rafamadriz/friendly-snippets' },
        },
    },
}
