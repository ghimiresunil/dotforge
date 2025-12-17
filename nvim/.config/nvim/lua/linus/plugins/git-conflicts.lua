return {
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("git-conflict").setup({
				default_mappings = false,
				disable_diagnostics = true,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})

			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map(
				"n",
				"<leader>Go",
				"<cmd>GitConflictChooseOurs<CR>",
				vim.tbl_extend("force", opts, { desc = "Choose Ours" })
			)
			map(
				"n",
				"<leader>Gt",
				"<cmd>GitConflictChooseTheirs<CR>",
				vim.tbl_extend("force", opts, { desc = "Choose Theirs" })
			)
			map(
				"n",
				"<leader>Gb",
				"<cmd>GitConflictChooseBoth<CR>",
				vim.tbl_extend("force", opts, { desc = "Choose Both" })
			)
			map(
				"n",
				"<leader>Gn",
				"<cmd>GitConflictChooseNone<CR>",
				vim.tbl_extend("force", opts, { desc = "Choose None" })
			)
			map(
				"n",
				"]x",
				"<cmd>GitConflictNextConflict<CR>",
				vim.tbl_extend("force", opts, { desc = "Next Conflict" })
			)
			map(
				"n",
				"[x",
				"<cmd>GitConflictPrevConflict<CR>",
				vim.tbl_extend("force", opts, { desc = "Prev Conflict" })
			)
		end,
	},
}
