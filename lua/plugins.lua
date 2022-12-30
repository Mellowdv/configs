return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
	use 'srcery-colors/srcery-vim'
    use 'hoob3rt/lualine.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = 'tsupdate' }
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'l3mon4d3/luasnip'
	use "mfussenegger/nvim-jdtls"
	use "p00f/clangd_extensions.nvim"
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'
	use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
end)
