return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000, -- Highest priority to ensure it loads first
		lazy = false, -- Load immediately (not lazy-loaded)
		config = function()
			require("kanagawa").setup({
				-- Core configuration
				compile = true, -- Compile for faster performance
				undercurl = true, -- Enable undercurls
				terminalColors = true, -- Set terminal colors
				transparent = false, -- Set to true for transparent background
				dimInactive = false, -- Don't dim inactive windows

				-- Style overrides
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = { bold = true },
					variables = {},
					constants = { bold = true },
					parameters = { italic = true },
				},

				-- Color palette customizations
				colors = {
					palette = {
						-- Slightly more vibrant colors
						sumiInk0 = "#16161D", -- Darker background
						waveBlue = "#7FB4CA", -- Brighter blue
						springViolet = "#938AA9", -- Softer violet
						nvimTreeBg = "#1F1F28",
					},
					theme = {
						all = {
							ui = {
								bg_gutter = "none", -- Cleaner gutter
							},
						},
					},
				},

				-- Advanced highlight overrides
				overrides = function(colors)
					local palette = colors.palette
					local theme = colors.theme
					return {
						-- Base enhancements
						Normal = { bg = palette.sumiInk0 }, -- Richer background
						NormalFloat = { bg = palette.sumiInk1 },
						FloatBorder = { fg = palette.waveBlue2, bg = palette.sumiInk1 },

						-- NvimTree specific background
						NvimTreeNormal = { bg = palette.nvimTreeBg },
						NvimTreeEndOfBuffer = { bg = palette.nvimTreeBg },

						-- Syntax improvements
						["@function"] = { fg = palette.carpYellow, bold = true },
						["@function.call"] = { fg = palette.carpYellow },
						["@parameter"] = { fg = palette.springBlue, italic = true },
						["@field"] = { fg = palette.boatYellow2 },
						["@property"] = { fg = palette.boatYellow2 },

						-- LSP enhancements
						DiagnosticError = { fg = palette.samuraiRed },
						DiagnosticWarn = { fg = palette.roninYellow },
						DiagnosticInfo = { fg = palette.waveAqua1 },
						DiagnosticHint = { fg = palette.dragonBlue },
						LspReferenceText = { bg = palette.sumiInk2 },
						LspReferenceRead = { bg = palette.sumiInk2 },
						LspReferenceWrite = { bg = palette.sumiInk3 },

						-- Telescope customization
						TelescopeTitle = { fg = palette.autumnRed, bold = true },
						TelescopeBorder = { fg = palette.waveBlue2, bg = palette.sumiInk1 },
						TelescopeSelection = { bg = palette.sumiInk2, bold = true },

						-- Pmenu (completion menu)
						Pmenu = { bg = palette.sumiInk1 },
						PmenuSel = { bg = palette.waveBlue2, fg = palette.sumiInk0 },
						PmenuSbar = { bg = palette.sumiInk1 },
						PmenuThumb = { bg = palette.waveBlue1 },

						-- Cmp (nvim-cmp)
						CmpItemAbbr = { fg = palette.fujiWhite },
						CmpItemAbbrMatch = { fg = palette.springGreen, bold = true },
						CmpItemKind = { fg = palette.autumnYellow },

						-- Git signs
						GitSignsAdd = { fg = palette.autumnGreen },
						GitSignsChange = { fg = palette.autumnYellow },
						GitSignsDelete = { fg = palette.autumnRed },

						-- Treesitter context
						TreesitterContext = { bg = palette.sumiInk2 },
						TreesitterContextLineNumber = { bg = palette.sumiInk2 },

						-- Indent blankline
						IndentBlanklineChar = { fg = palette.sumiInk3 },
						IndentBlanklineContextChar = { fg = palette.waveBlue1 },

						-- Dashboard (alpha.nvim)
						AlphaHeader = { fg = palette.waveAqua2 },
						AlphaButtons = { fg = palette.fujiWhite },
						AlphaFooter = { fg = palette.autumnYellow },
					}
				end,

				-- Plugin integrations
				integrations = {
					aerial = true,
					barbar = true,
					cmp = true,
					dashboard = true,
					dap = { enabled = true, enable_ui = true },
					dropbar = { enabled = true, color_mode = true },
					flash = true,
					gitsigns = true,
					headlines = true,
					illuminate = true,
					indent_blankline = { enabled = true, colored_indent_levels = false },
					leap = true,
					lsp_trouble = true,
					mason = true,
					markdown = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { italic = true },
							hints = { italic = true },
							warnings = { italic = true },
							information = { italic = true },
						},
						underlines = {
							errors = { undercurl = true },
							hints = { undercurl = true },
							warnings = { undercurl = true },
							information = { undercurl = true },
						},
					},
					neotest = true,
					neotree = true,
					noice = true,
					notify = true,
					nvimtree = true,
					semantic_tokens = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
			})

			-- Apply colorscheme with fallback
			vim.cmd([[
        try
          colorscheme kanagawa-wave
        catch /^Vim\%((\a\+)\)\=:E185/
          colorscheme default
          set background=dark
        endtry
      ]])
		end,
	},
}
