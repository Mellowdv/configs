require('plugins')
local vim = vim

-- telescope fuzzy extension and commands

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', '<space>lds', builtin.lsp_document_symbols, {})

require("mason").setup({
	automatic_installation = true
})
require("mason-lspconfig").setup({
    ensure_installed = { 'sumneko_lua', 'pylsp', 'jdtls', 'rust_analyzer', 'hls'}
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

vim.opt.termguicolors = true
require('nvim-web-devicons').setup {
    override = {},
    default = true
}

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp servers config

require("clangd_extensions").setup {
	server = {
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	}
}
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
require('lspconfig')['asm_lsp'].setup {
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

-- colorscheme
vim.cmd [[
	colorscheme srcery
]]

-- lualine config
require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = 'codedark',
    }
}

-- bufferline config
local bufferline = require("bufferline")
bufferline.setup{
    options = {
        mode = 'buffers',
        numbers = 'ordinal',
        color_icons = true,
    },
    highlights = {
        buffer_selected = {
            italic = false
        }
    }
}

-- bufferline bindings for jumping to buffers
vim.keymap.set('n', '<Space>1', ':BufferLineGoToBuffer 1<CR>', { silent = true })
vim.keymap.set('n', '<Space>2', ':BufferLineGoToBuffer 2<CR>', { silent = true })
vim.keymap.set('n', '<Space>3', ':BufferLineGoToBuffer 3<CR>', { silent = true })
vim.keymap.set('n', '<Space>4', ':BufferLineGoToBuffer 4<CR>', { silent = true })
vim.keymap.set('n', '<Space>5', ':BufferLineGoToBuffer 5<CR>', { silent = true })
vim.keymap.set('n', '<Space>6', ':BufferLineGoToBuffer 6<CR>', { silent = true })
vim.keymap.set('n', '<Space>7', ':BufferLineGoToBuffer 7<CR>', { silent = true })
vim.keymap.set('n', '<Space>8', ':BufferLineGoToBuffer 8<CR>', { silent = true })
vim.keymap.set('n', '<Space>9', ':BufferLineGoToBuffer 9<CR>', { silent = true })
vim.keymap.set('n', '<Space>$', ':BufferLineGoToBuffer -1<CR>', { silent = true })


-- general Vim options
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.relativenumber=true
vim.opt.number=true
vim.opt.expandtab=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
