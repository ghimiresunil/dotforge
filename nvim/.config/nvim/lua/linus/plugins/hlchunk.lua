return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local configs = {
      chunk = {
        enable = true,
        style = {
          { fg = "#806d9c" },
          { fg = "#f35336" },
        },
      },
    }

    require("hlchunk").setup(configs)
  end,
}

