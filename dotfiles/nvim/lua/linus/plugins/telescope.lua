return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")
		local builtin = require("telescope.builtin")

		local previewers = require("telescope.previewers")
		local sorters = require("telescope.sorters")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ", -- (can replace with your own icons later)
				selection_caret = " ", -- (nice arrow)
				path_display = { "smart" },
				color_devicons = true,
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				scroll_strategy = "limit",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.8,
					},
					vertical = { mirror = false },
					width = 0.85,
					height = 0.92,
					preview_cutoff = 120,
				},
				file_ignore_patterns = { ".git/", ".cache/", "%.o", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
				file_previewer = previewers.vim_buffer_cat.new,
				grep_previewer = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,
				generic_sorter = sorters.get_generic_fuzzy_sorter,
				buffer_previewer_maker = previewers.buffer_previewer_maker,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.smart_send_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
						["<esc>"] = actions.close,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in cwd" })
		-- keymap.set("n", "<leader>fa", function()
		-- 	builtin.find_files({ hidden = true, no_ignore = true })
		-- end, { desc = "Find all files (including hidden)" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recently opened files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd (live grep)" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODO comments" })

		-- Show current buffer with its number
		keymap.set("n", "<leader>fv", function()
			builtin.buffers({
				show_all_buffers = false, -- Only show visible buffers
				sort_mru = true,
			})
		end, { desc = "Find visible buffers" })

		keymap.set("n", "<leader>fa", function()
			builtin.find_files({
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--no-ignore",
					"--glob",
					".env",
					"--glob",
					".pre-commit-config.yaml",
					"--glob",
					".secrets*.toml",
				},
			})
		end, { desc = "Find selected hidden dotfiles" })
	end,
}
