local packer = require('packer')

packer.startup(function()
	use {
		'wbthomason/packer.nvim',
		branch = 'release'

	}

	use {
        'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

	use 'neoclide/coc.nvim'

	use ({ 'projekt0n/github-nvim-theme' })

	use 'L3MON4D3/LuaSnip'

	use({ 'mhartington/formatter.nvim' })

	use({
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	})

	use({
  		'nvim-telescope/telescope.nvim',
  		requires = { {'nvim-lua/plenary.nvim'} }
	})

	use({'lewis6991/gitsigns.nvim'})

	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
		  'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {} end
	}

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
end)
