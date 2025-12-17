return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			-- Define formatters per filetype
			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" }, -- Auto-fix + format
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				lua = { "stylua" },
				toml = { "taplo" },
			},
			-- Format on save
			format_on_save = {
				lsp_fallback = true, -- Fallback to LSP if formatter fails
				async = false, -- Run synchronously
				timeout_ms = 1000, -- Timeout after 1s
			},
		})

		-- Keymap to format manually
		vim.keymap.set({ "n", "v" }, "<leader>mp", conform.format, { desc = "Format file/range" })
	end,
}
