return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.config",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
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
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>xs"] = { query = "@parameter.inner", desc = "Swap with next" },
        },
        swap_previous = {
          ["<leader>xS"] = { query = "@parameter.inner", desc = "Swap with previous" },
        },
      },
    },
  },
}
