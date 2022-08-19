return function(bootstrap)
    -- automatically run :PackerCompile whenever plugins.lua is updated
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = 'plugins.lua',
        -- command = 'source <afile> | PackerUpdate',
        callback = function()
            local file, err = loadfile(vim.fn.expand('<afile>'))
            if file then
                file()
            else
                vim.api.nvim_err_writeln(err)
            end
            require'packer'.compile()
        end,
        group = vim.api.nvim_create_augroup('PackerUserConfig', { clear = true }),
    })

    local packer = require'packer'

    if bootstrap then
        vim.api.nvim_create_autocmd('User', {
            pattern = 'PackerComplete',
            callback = function()
                print('Restart Neovim to complete installation')
            end,
            once = true,
        })
    end

    packer.startup(function(use)
        use { 'wbthomason/packer.nvim' }

        -- Themes --------------------------------------------------------
        use { 'tomasr/molokai',
            config = function()
                vim.cmd [[colorscheme molokai]]
            end
        }
        -- use { 'joshdick/onedark.vim' }
        -- use { 'tomasiser/vim-code-dark' }
        -- use { 'ayu-theme/ayu-vim' }
        -- use { 'NLKNguyen/papercolor-theme' }
        use { 'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- LSP -----------------------------------------------------------
        use { 'neovim/nvim-lspconfig' }
        use { 'onsails/lspkind-nvim' }
        use { 'folke/trouble.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                vim.keymap.set('n', '<leader>q', require'trouble'.toggle, { noremap = true })
            end,
        }
        use { 'simrat39/symbols-outline.nvim',
            config = function()
                require'symbols-outline'.setup()
            end
        }

        -- Completion ----------------------------------------------------
        use { 'hrsh7th/nvim-cmp' }
        use { 'hrsh7th/cmp-nvim-lsp' }
        use { 'hrsh7th/cmp-nvim-lua' }
        use { 'hrsh7th/cmp-buffer' }
        use { 'hrsh7th/cmp-path' }
        use { 'hrsh7th/cmp-cmdline' }
        use { 'hrsh7th/cmp-nvim-lsp-signature-help' }

        -- Snippets ------------------------------------------------------
        -- use { 'hrsh7th/vim-vsnip', event = 'InsertEnter' }
        use { 'L3MON4D3/LuaSnip' }
        use { 'saadparwaiz1/cmp_luasnip' }

        -- Telescope -----------------------------------------------------
        use { 'nvim-telescope/telescope.nvim',
              requires = { 'nvim-lua/popup.nvim', { 'nvim-lua/plenary.nvim' } },
              config = function()
                  require'telescope'.setup {
                      extensions = {
                          fzf = {
                              fuzzy = true,
                              override_generic_sorter = true,
                              override_file_sorter = true,
                              case_mode = 'smart_case',
                          },
                          ['ui-select'] = {
                              require'telescope.themes'.get_dropdown {
                              }
                          },
                      }
                  }
              end
        }
        use { 'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function()
                require'telescope'.load_extension('fzf')
            end
        }
        use { 'nvim-telescope/telescope-ui-select.nvim',
            config = function ()
                require'telescope'.load_extension('ui-select')
            end
        }

        -- Treesitter ----------------------------------------------------
        use { 'nvim-treesitter/nvim-treesitter',
            run = function()
                if not bootstrap then
                    vim.cmd [[TSUpdate]]
                end
            end,
            config = function()
                if bootstrap then
                    return
                end

                require'nvim-treesitter.configs'.setup {
                    -- ensure_installed = { 'c', 'cpp', 'python', 'rust', 'lua', 'haskell',
                    --                      'bash', 'toml', 'json', 'jsonc', 'yaml', 'html',
                    --                      'devicetree', 'verilog', 'gdscript', 'regex',
                    --                      'rst', 'latex', 'comment', 'query', 'wgsl' },
                    ensure_installed = 'all',
                    highlight = {
                        enable = true,
                        disable = {}
                    },
                    incremental_selection = {
                        enable = true,
                    },
                    -- indent = {
                    --     enable = true
                    -- },
                }


                vim.opt.foldmethod = 'expr'
                vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
                vim.opt.foldlevelstart = 99
            end
        }
        use { 'nvim-treesitter/playground' }

        -- Other Plugins -------------------------------------------------

        -- use { 'editorconfig/editorconfig-vim' }

        use { 'norcalli/nvim-colorizer.lua',
            config = function()
                require'colorizer'.setup({
                    '*'
                }, {
                    RGB = true,
                    RRGGBB = true,
                    names = false,
                    RRGGBBAA = false,
                    rgb_fn = true,
                    hsl_fn = true,
                    mode = 'background',
                })
            end
        }

        use { 'vimwiki/vimwiki',
            setup = function()
                vim.g.vimwiki_list = {
                    {
                        path = '~/notes',
                        syntax = 'markdown',
                        ext = '.md',
                    },
                }
            end
        }
        use { 'tpope/vim-fugitive' }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require'Comment'.setup()
            end
        }

        use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }

        use { 'akinsho/toggleterm.nvim',
            config = function()
                -- setting open_mapping to '<leader><cr>' seems to be buggy (space is mapped in insert mode?)
                require'toggleterm'.setup()

                local Terminal = require'toggleterm.terminal'.Terminal
                local term = Terminal:new {
                    direction = 'float',
                }

                vim.keymap.set('n', '<leader><cr>', function() term:toggle() end, { noremap = true })
            end
        }

        if bootstrap then
            require'packer'.sync()
        end
    end)

    if not bootstrap then
        -- auto install missing plugins
        require'packer'.install()
    end
end
