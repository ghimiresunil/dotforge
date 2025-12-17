return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag", -- Safe to leave, but not necessary without HTML/JS
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      -- Enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- Enable indentation
      indent = {
        enable = true,
      },
      -- You can remove this if you're not using HTML/JSX/TSX
      autotag = {
        enable = false,
      },
      -- Install only parsers relevant to Python ML work
      ensure_installed = {
        "python",
        "lua",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "dockerfile",
        "gitignore",
      },
      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      -- Optional: auto-install missing parsers
      auto_install = true,
    })
  end,
}

