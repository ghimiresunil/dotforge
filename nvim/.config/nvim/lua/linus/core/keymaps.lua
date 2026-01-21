-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Close the current buffer

keymap.set("n", "<leader>bb", function()
  require("bufferline").pick()
end, { desc = "Pick buffer" })

keymap.set("n", "<leader>bd", function()
  require("bufferline").pick(function(bufnr)
    vim.cmd("bdelete " .. bufnr)
  end)
end, { desc = "Pick buffer to close" })

keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
-- Go to next buffer
keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
-- Go to previous buffer
keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
-- Move current buffer to the right
keymap.set("n", "<leader>br", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
-- Move current buffer to the left
keymap.set("n", "<leader>bl", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

-- Window resizing with <leader> + h/j/k/l
-- keymap.set('n', '<Up>', ':resize -2<CR>', opts)
-- keymap.set('n', '<Down>', ':resize +2<CR>', opts)
-- keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
-- keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Window resizing with <leader> + arrow keys
keymap.set("n", "<leader><Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<leader><Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<leader><Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
keymap.set("n", "<leader><Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
