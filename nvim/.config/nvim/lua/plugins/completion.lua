return {
	-- nvim-cmp completion plugin
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completion
			"hrsh7th/cmp-buffer", -- Buffer completion
			"hrsh7th/cmp-path", -- Path completion
			"hrsh7th/cmp-cmdline", -- Command-line completion
			"saadparwaiz1/cmp_luasnip", -- Snippet completion
			"L3MON4D3/LuaSnip", -- Snippet engine
		},
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					-- REQUIRED: Specify how to expand snippets
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP completion
					{ name = "luasnip" }, -- Snippets
				}, {
					{ name = "buffer" }, -- Buffer completion
				}),
			})
			-- Use buffer source for `/`
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':'
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	-- LuaSnip for snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Optional: community snippets
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-style snippets
		end,
	},
}
