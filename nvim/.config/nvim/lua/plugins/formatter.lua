return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewfile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "black" },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = true,
					timeout_ms = 5000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
}
