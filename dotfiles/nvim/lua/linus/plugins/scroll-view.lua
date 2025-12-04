return {
  "dstein64/nvim-scrollview",
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  lazy = true,
  config = function()
    -- Define diagnostic icons directly
    local diagnostics_icons = {
      Error = "",
		  Warning = "",
		  Information = "",
		  Question = "",
		  Hint = "󰌵",
		  -- Hollow version
		  Error_alt = "󰅚",
		  Warning_alt = "󰀪",
		  Information_alt = "",
		  Question_alt = "",
		  Hint_alt = "󰌶",
    }

    require("scrollview").setup({
      mode = "virtual",
      winblend = 0,
      signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
      diagnostics_error_symbol = diagnostics_icons.Error,
      diagnostics_warn_symbol = diagnostics_icons.Warning,
      diagnostics_info_symbol = diagnostics_icons.Information,
      diagnostics_hint_symbol = diagnostics_icons.Hint,
      excluded_filetypes = {
        "alpha",
        "fugitive",
        "git",
        "notify",
        "NvimTree",
        "Outline",
        "TelescopePrompt",
        "toggleterm",
        "undotree",
      },
    })
  end,
}

