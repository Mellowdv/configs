local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plug')

Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'kyazdani42/nvim-web-devicons'
Plug "mfussenegger/nvim-jdtls"
Plug "p00f/clangd_extensions.nvim"

vim.call('plug#end')

require("nvim-lsp-installer").setup({
	automatic_installation = true
})

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp", "lua", "bash", "python", "c", "haskell" },
	sync_install = false,
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
}

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4

-- lsp config

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- on_attach for mapping keys after server attachment to buffer
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- mappings

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
	debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("clangd_extensions").setup()

---require('lspconfig')['clangd'].setup {
---	on_attach = on_attach,
---	flags = lsp_flags,
---	capabilities = capabilities,
---}
require('lspconfig')['sumneko_lua'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['pyright'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['jdtls'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['hls'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['rust_analyzer'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['C-Space'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}

vim.cmd [[
	colorscheme srcery
	let g:lightline = { 
		\ 'colorscheme': 'srcery', 
		\ }
]]

vim.opt.shiftwidth=4
vim.opt.softtabstop=4
