-- automatically run :PackerCompile whenever plugins.lua is updated
local packer_user_config = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
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
    group = packer_user_config,
})

local packer = require'packer'

packer.init {
    compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
}

packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- Themes --------------------------------------------------------
    use { 'tomasr/molokai',
        config = function()
            vim.cmd [[colorscheme molokai]]
        end
    }
    use { 'joshdick/onedark.vim' }
    -- use { 'tomasiser/vim-code-dark' }
    use { 'ayu-theme/ayu-vim' }
    use { 'NLKNguyen/papercolor-theme' }
    use { 'nvim-lualine/lualine.nvim' }
    -- use { 'vim-airline/vim-airline',
    --     config = function()
    --         vim.g.airline_powerline_fonts = 1
    --         vim.g['airline#extensions#tabline#enabled'] = 1
    --     end
    -- }
    -- use { 'vim-airline/vim-airline-themes' }

    -- LSP -----------------------------------------------------------
    use { 'neovim/nvim-lspconfig' }
    -- use { 'tjdevries/nlua.nvim' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'onsails/lspkind-nvim' }
    use { 'folke/trouble.nvim' }
    -- use { 'glepnir/lspsaga.nvim',
    --     config = function()
    --         require'lspsaga'.init_lsp_saga()
    --     end
    -- }

    -- Completion ----------------------------------------------------
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }

    -- Snippets ------------------------------------------------------
    -- use { 'hrsh7th/vim-vsnip', event = 'InsertEnter' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

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
            if not PACKER_BOOTSRAP then
                vim.cmd [[TSUpdate]]
            end
        end,
        config = function()
            -- local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            -- parser_config.wgsl = {
            --     install_info = {
            --         url = 'https://github.com/szebniok/tree-sitter-wgsl',
            --         files = {'src/parser.c'}
            --     },
            -- }

            if PACKER_BOOTSTRAP then
                return
            end
            require'nvim-treesitter.configs'.setup {
                -- ensure_installed = { 'c', 'cpp', 'python', 'rust', 'lua', 'haskell',
                --                      'bash', 'toml', 'json', 'jsonc', 'yaml', 'html',
                --                      'devicetree', 'verilog', 'gdscript', 'regex',
                --                      'rst', 'latex', 'comment', 'query', 'wgsl' },
                ensure_installed = 'all',
                ignore_install = { 'phpdoc' },
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


            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.o.foldlevelstart = 99
        end
    }
    use { 'nvim-treesitter/playground' }

    -- Other Plugins -------------------------------------------------
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

    use { 'github/copilot.vim' }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require'Comment'.setup()
        end
    }

    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }

    use { 'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_keymap_toggle = '<leader><cr>'
        end
    }

    if PACKER_BOOTSTRAP then
        require'packer'.sync()
    end
end)

if PACKER_BOOTSTRAP then
    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerComplete',
        callback = function()
            print('Restart Neovim to complete installation')
        end,
        once = true,
    })
    return
end

-- auto install missing plugins
require'packer'.install()


-- fix theme for global status line
vim.api.nvim_set_hl(0, 'WinSeparator', {
    fg = vim.api.nvim_get_hl_by_name('VertSplit', true).foreground,
    -- bg = 'None', None is default
})
