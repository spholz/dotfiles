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
    Function = '', -- 
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
        ['<C-y>'] = cmp.mapping.confirm { select = true }, -- default is select = false
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-h>'] = cmp.mapping.abort {},
        ['<C-j>'] = cmp.mapping.select_next_item {},
        ['<C-k>'] = cmp.mapping.select_prev_item {},
        ['<C-l>'] = cmp.mapping.confirm { select = true },
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
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
        ---@return any
        format = function(entry, vim_item)
            vim_item.kind = lsp_icons[vim_item.kind] or vim_item.kind
            vim_item.menu = ({
                buffer = ' ',
                nvim_lsp = '  ',
                nvim_lua = ' ',
                path = ' ',
                luasnip = ' ',
            })[entry.source.name]

            return vim_item
        end,
    },

    -- view = {
    --     entries = 'native',
    -- },

    -- experimental = {
    --     ghost_text = true,
    -- },
}

-- cmp.setup.cmdline(':', {
--     completion = {
--         autocomplete = false,
--     },
--     mapping = cmp.mapping.preset.cmdline(),
--     formatting = {
--         fields = { 'abbr' },
--     },
--     sources = cmp.config.sources({
--         { name = 'path' },
--     }, {
--         { name = 'cmdline' },
--     }),
-- })
-- 
-- cmp.setup.cmdline('/', {
--     completion = {
--         autocomplete = false,
--     },
--     mapping = cmp.mapping.preset.cmdline(),
--     formatting = {
--         fields = { 'abbr', 'kind' },
--         format = function(entry, vim_item)
--             vim_item.kind = '[' .. entry.source.name .. ']'
--             return vim_item
--         end,
--     },
--     sources = {
--         { name = 'buffer' },
--     },
-- })
