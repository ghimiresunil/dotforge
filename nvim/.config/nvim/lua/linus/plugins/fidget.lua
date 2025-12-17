return {
  "j-hui/fidget.nvim",
  tag = "legacy", -- optional: use "legacy" or remove for latest
  event = "LspAttach",
  config = function()
    local icons = {
      ui = {
        Accepted = "",
      },
    }

    local configs = {
      progress = {
        suppress_on_insert = false,
        ignore_done_already = false,
        ignore = { "null-ls" },
        display = {
          render_limit = 5,
          done_ttl = 2,
          done_icon = icons.ui.Accepted,
        },
      },
      notification = {
        override_vim_notify = false,
        window = {
          winblend = 0,
          zindex = 75,
        },
      },
    }

    require("fidget").setup(configs)
  end,
}

