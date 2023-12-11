return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = 'TSUpdate',
    },

    {
        'nvim-lua/plenary.nvim',
    },

    {
        'nvim-telescope/telescope.nvim'
    },

    {
        'junegunn/fzf',
    },

    {
        'junegunn/fzf.vim',
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=release && cmake --build build --config Release && cmake --install build --prefix build',
    },

    {
        'nvim-tree/nvim-web-devicons',
    },

    {
        'nvim-lualine/lualine.nvim',
    },

    {
        'williamboman/mason.nvim',
    },

    {
        'williamboman/mason-lspconfig.nvim',
    },

    {
        'neovim/nvim-lspconfig',
    },

    {
        'hrsh7th/nvim-cmp',
    },

    {
        'hrsh7th/cmp-nvim-lsp',
    },

    {
        'saadparwaiz1/cmp_luasnip',
    },

    {
        'l3mon4d3/luasnip',
    },

    {
        'p00f/clangd_extensions.nvim',
    },

    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
}
