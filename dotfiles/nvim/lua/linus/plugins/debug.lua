return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"folke/which-key.nvim", -- 👈 Add this if not already installed
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")

			-- Setup DAP UI
			dapui.setup({})
			require("nvim-dap-virtual-text").setup({ commented = true })

			-- Setup Python DAP
			dap_python.setup("python3")

			-- Python debug configurations
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Debug pytest",
					module = "pytest",
					args = { "--maxfail=1", "--disable-warnings", "-q" },
					console = "integratedTerminal",
				},
				{
					type = "python",
					request = "launch",
					name = "Debug FastAPI",
					program = "${workspaceFolder}/app.py",
					console = "integratedTerminal",
				},
				{
					type = "python",
					request = "launch",
					name = "Debug Flask",
					module = "flask",
					env = {
						FLASK_APP = "application.py",
						FLASK_ENV = "dev",
					},
					args = { "run", "--reload", "--port", "8000" },
					jinja = true,
					console = "integratedTerminal",
				},
				{
					type = "python",
					request = "launch",
					name = "Debug current file",
					program = "${file}",
					console = "integratedTerminal",
				},
			}

			-- Define breakpoint signs
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local opts = { noremap = true, silent = true }

			-- Basic keymaps (for fallback)
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
			vim.keymap.set("n", "<leader>dc", dap.continue, opts)
			vim.keymap.set("n", "<leader>do", dap.step_over, opts)
			vim.keymap.set("n", "<leader>di", dap.step_into, opts)
			vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
			vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
			vim.keymap.set("n", "<leader>du", dapui.toggle, opts)

			-- which-key descriptions 👇
			local wk = require("which-key")
			wk.add({
				{ "<leader>d", group = "Debug" },
				{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
				{ "<leader>dc", dap.continue, desc = "Continue debugging" },
				{ "<leader>do", dap.step_over, desc = "Step over" },
				{ "<leader>di", dap.step_into, desc = "Step into" },
				{ "<leader>dO", dap.step_out, desc = "Step out" },
				{ "<leader>dq", dap.terminate, desc = "Terminate debug session" },
				{ "<leader>du", dapui.toggle, desc = "Toggle DAP UI" },
			})
		end,
	},
}
