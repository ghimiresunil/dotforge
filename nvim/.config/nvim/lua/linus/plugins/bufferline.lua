return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      themable = true, -- allows highlight groups to be overridden
      numbers = "ordinal",
      close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
      indicator = {
        icon = "▎", -- indicator icon
        style = "icon",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "● ",
      close_icon = " ",
      left_trunc_marker = " ",
      right_trunc_marker = " ",
      name_formatter = function(buf) -- buf contains: name, path, bufnr, buffers, tabnr
        return vim.fn.fnamemodify(buf.path, ':t') -- Extract filename from path
      end,
      max_name_length = 20, -- Adjust based on your preference
      max_prefix_length = 13, -- Prefix length for de-duplicated buffers
      truncate_names = true, -- Whether to truncate names
      tab_size = 20,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_update_on_event = true,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
      custom_filter = function(buf_number, buf_numbers)
        -- Filter out unwanted buffers based on filetype, name, or other criteria
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          return true
        end
        if buf_numbers[1] ~= buf_number then
          return true
        end
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      color_icons = true,
      get_element_icon = function(element)
        local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      duplicates_across_groups = true,
      persist_buffer_sort = true,
      move_wraps_at_ends = false,
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      auto_toggle_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      sort_by = 'insert_at_end'
    },
  },
}
