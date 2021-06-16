function plugin_config()
    vim.g.neon_style = "doom"
    vim.g.ayu_mirage = true

    require'lspconfig'.gdscript.setup{}
    require'colorizer'.setup()
    require'lualine'.setup({
        options = {
            component_separators = '',
            section_separators = ''
        },
        tabline = {
            lualine_a = {},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        }
    })
    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            use_languagetree = false, -- Use this to enable language injection (this is very unstable)
        },
    }
    require'nvim-web-devicons'.setup {
        default = true;
    }
    require'kommentary.config'.use_extended_mappings()
    local actions = require('telescope.actions')
    require'telescope'.setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                }
            }
        }
    }
    require'presence':setup {
        auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image          = "file",                   -- Main image display (either "neovim" or "file")
        client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level           = "error",                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = false,                      -- Displays the current line number instead of the current project

        -- Rich Presence text options
        editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
        git_commit_text     = "Committing changes",       -- Format string rendered when commiting changes in git
        plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins
        reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
        workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
    }
end

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'norcalli/nvim-colorizer.lua'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/playground'}
    use {'rafamadriz/neon'}
    use {'hoob3rt/lualine.nvim'}
    use {'jiangmiao/auto-pairs'}
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-compe'}
    use {'folke/lsp-colors.nvim'}
    use {'mcchrish/nnn.vim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'b3nj5m1n/kommentary'}
    use {'mhinz/vim-crates'}
    use {'mhinz/vim-startify'}
    use {'alaviss/nim.nvim'}
    use {'fratajczak/one-monokai-vim'}
    use {'preservim/nerdtree'}
    use {'RRethy/nvim-base16'}
    use {'sainnhe/sonokai'}
    use {'famiu/bufdelete.nvim'}
    use {'Yggdroot/indentLine'}
    use {'Shatur/neovim-ayu'}
    use {'ray-x/lsp_signature.nvim'}
    use {'andweeb/presence.nvim'}
    use {'junegunn/fzf.vim'}
    use {'ggandor/lightspeed.nvim'}

    plugin_config()
end)


