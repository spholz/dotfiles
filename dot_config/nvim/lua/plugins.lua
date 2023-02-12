return function(bootstrap)
    -- automatically run :PackerCompile whenever a lua file in the neovim config dir is updated
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = vim.fn.stdpath 'config' .. '/*.lua', -- note: '*' matches '/' as well
        callback = function()
            local file, err = loadfile(vim.fn.expand '<afile>')
            if file then
                file()
            else
                vim.api.nvim_err_writeln(err)
            end
            require('packer').compile()
        end,
        group = vim.api.nvim_create_augroup('auto_reload_config', { clear = true }),
    })

    local packer = require 'packer'

    packer.startup(function(use)
        use { 'wbthomason/packer.nvim' }

        --- Themes --------------------------------------------------------
        use {
            'tomasr/molokai',
            config = [[require 'config.colorscheme']],
            after = 'lualine.nvim',
        }
        use { 'sainnhe/sonokai' }
        use { 'EdenEast/nightfox.nvim' }
        use { 'joshdick/onedark.vim' }
        use { 'tomasiser/vim-code-dark' }
        use { 'ayu-theme/ayu-vim' }
        use { 'NLKNguyen/papercolor-theme' }
        use { 'drewtempelmeyer/palenight.vim' }
        use { 'sonph/onehalf', rtp = 'vim' }
        use { 'kyoz/purify', rtp = 'vim' }
        use { 'dracula/vim', as = 'dracula' }
        use { 'rebelot/kanagawa.nvim' }

        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
            },
            config = [[require 'config.plugin.lualine']],
            after = 'nvim-lspconfig', -- for lsp-status register_progress()
        }

        use {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup {}
            end,
        }
        use {
            'williamboman/mason-lspconfig.nvim',
            config = [[require 'config.plugin.mason_lspconfig']],
            after = 'nvim-lspconfig',
        }

        --- LSP -----------------------------------------------------------
        use {
            'neovim/nvim-lspconfig',
            -- config = [[require 'config.plugin.lspconfig']], -- conflicts with mason-lspconfig config
            after = 'cmp-nvim-lsp', -- for update_capabilities()
        }
        -- use { 'scalameta/nvim-metals', requires = 'nvim-lua/plenary.nvim' }
        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                local map_with_desc = require('util.keymap').map_with_desc

                map_with_desc(
                    'n',
                    '<Leader>q',
                    require('trouble').toggle,
                    { noremap = true },
                    'Toggle trouble.nvim list'
                )
            end,
        }
        use {
            'simrat39/symbols-outline.nvim',
            config = function()
                require('symbols-outline').setup()
            end,
        }

        use {
            'j-hui/fidget.nvim',
            config = function()
                require('fidget').setup {
                    text = {
                        spinner = 'dots_snake',
                        done = '',
                    },
                }
            end,
        }

        --- Completion ----------------------------------------------------
        use {
            'hrsh7th/nvim-cmp',
            config = [[require 'config.plugin.cmp']],
            requires = {
                { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
                { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' },
                { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
                { 'rafamadriz/friendly-snippets', after = 'LuaSnip' },
            },
        }

        --- Telescope -----------------------------------------------------
        use {
            'nvim-telescope/telescope.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('telescope').setup {
                    extensions = {
                        fzf = {
                            fuzzy = true,
                            override_generic_sorter = true,
                            override_file_sorter = true,
                            case_mode = 'smart_case',
                        },
                        ['ui-select'] = {
                            require('telescope.themes').get_dropdown {},
                        },
                    },
                }
            end,
        }

        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function()
                require('telescope').load_extension 'fzf'
            end,
            cond = vim.fn.executable 'make' == 1,
        }

        use {
            'nvim-telescope/telescope-ui-select.nvim',
            config = function()
                require('telescope').load_extension 'ui-select'
            end,
        }

        --- Treesitter ----------------------------------------------------
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                require('nvim-treesitter.install').update { with_sync = true }
            end,
            config = [[require 'config.plugin.treesitter']],
        }
        use { 'nvim-treesitter/playground' }
        use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
        use { 'nvim-treesitter/nvim-treesitter-context' }

        --- Other Plugins -------------------------------------------------

        -- use { 'editorconfig/editorconfig-vim' }

        use {
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup({
                    '*',
                }, {
                    RGB = true,
                    RRGGBB = true,
                    names = false,
                    RRGGBBAA = false,
                    rgb_fn = true,
                    hsl_fn = true,
                    mode = 'background',
                })
            end,
        }

        use { 'tpope/vim-fugitive', requires = 'tpope/vim-rhubarb' }

        use { 'tpope/vim-sleuth' }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end,
        }

        use { 'rcarriga/nvim-dap-ui', requires = 'mfussenegger/nvim-dap' }

        use {
            'akinsho/toggleterm.nvim',
            config = function()
                -- setting open_mapping to '<Leader><CR>' seems to be buggy (space is mapped in insert mode?)
                require('toggleterm').setup()

                local Terminal = require('toggleterm.terminal').Terminal
                local term = Terminal:new {
                    direction = 'float',
                }

                local map_with_desc = require('util.keymap').map_with_desc

                map_with_desc('n', '<Leader><CR>', function()
                    term:toggle()
                end, { noremap = true }, 'Toggle floating terminal')
            end,
        }

        use {
            'jose-elias-alvarez/null-ls.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                local null_ls = require 'null-ls'
                null_ls.setup {
                    sources = {
                        null_ls.builtins.formatting.stylua,
                        null_ls.builtins.diagnostics.cppcheck,
                        null_ls.builtins.diagnostics.fish,
                        null_ls.builtins.diagnostics.gitlint,
                        null_ls.builtins.diagnostics.glslc,
                        -- null_ls.builtins.diagnostics.markdownlint,
                        -- null_ls.builtins.diagnostics.mypy,
                        -- null_ls.builtins.diagnostics.pylint,
                        null_ls.builtins.diagnostics.qmllint,
                        null_ls.builtins.diagnostics.rstcheck,
                        null_ls.builtins.diagnostics.shellcheck,
                        null_ls.builtins.diagnostics.zsh,
                        -- null_ls.builtins.diagnostics.trail_space,
                    },
                }
            end,
        }

        use { 'mbbill/undotree' }

        use { 'wsdjeg/vim-fetch' } -- for filename:line:column

        if bootstrap then
            require('packer').sync()
        end
    end)

    if not bootstrap then
        -- auto install missing plugins
        require('packer').install()
    end
end
