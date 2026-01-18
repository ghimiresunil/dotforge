return {
  "XXiaoA/atone.nvim",
  cmd = "Atone",
  opts = {
    layout = {
      direction = "left", -- or "right"
      width = 0.25, -- 25% of screen
    },

    diff_cur_node = {
      enabled = true,
      split_percent = 0.3,
    },

    auto_attach = {
      enabled = true,
      excluded_ft = { "oil", "neo-tree" },
    },

    ui = {
      border = "single", -- "none", "rounded", "double"
      compact = false,
    },

    keymaps = {
      tree = {
        quit = { "q", "<C-c>" },
        next_node = "j",
        pre_node = "k",
        jump_to_G = "G",
        jump_to_gg = "gg",
        undo_to = "<CR>",
        help = { "?", "g?" },
      },
      auto_diff = {
        quit = { "q", "<C-c>" },
        help = { "?", "g?" },
      },
      help = {
        quit_help = { "q", "<C-c>" },
      },
    },
  },
}
