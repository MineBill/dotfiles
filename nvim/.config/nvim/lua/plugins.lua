function plugin_config()
    vim.g.neon_style = "doom"

    require'lspconfig'.gdscript.setup{}
    require'colorizer'.setup()
    require'lualine'.setup({
        options = {
            theme = 'neon',
            component_separators = '',
            section_separators = ''
        },
        tabline = {
            lualine_a = {},
            lualine_b = {},
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

    plugin_config()
end)


