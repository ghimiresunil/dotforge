---@diagnostic disable: deprecated

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- Set up diagnostic signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- LSP keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Capabilities for nvim-cmp
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Mason LSP handlers
		mason_lspconfig.setup_handlers({
			-- Default handler for any server
			function(server_name)
				vim.lsp.config(server_name, { capabilities = capabilities })
				vim.lsp.enable(server_name)
			end,

			-- Lua
			["lua_ls"] = function()
				vim.lsp.config("lua_ls", {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					},
				})
				vim.lsp.enable("lua_ls")
			end,

			-- Pyright
			["pyright"] = function()
				vim.lsp.config("pyright", {
					capabilities = capabilities,
					settings = {
						pyright = {
							disableOrganizeImports = false,
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				})
				vim.lsp.enable("pyright")
			end,

			-- Pylsp
			["pylsp"] = function()
				vim.lsp.config("pylsp", {
					capabilities = capabilities,
					settings = {
						pylsp = {
							plugins = {
								ignore = { "W391" },
								maxLineLength = 100,
								pycodestyle = { enabled = false },
								pyflakes = { enabled = false },
								pylint = { enabled = false },
								autopep8 = { enabled = false },
								yapf = { enabled = false },
								jedi_completion = { enabled = false },
								pylsp_mypy = { enabled = false },
								ruff = {
									enabled = true,
									extendSelect = {},
									format = { enabled = true },
								},
							},
						},
					},
				})
				vim.lsp.enable("pylsp")
			end,
		})
	end,
}
