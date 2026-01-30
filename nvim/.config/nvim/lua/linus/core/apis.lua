local fn = vim.fn
local vcmd = vim.cmd
local keymap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup

autogroup("bufcheck", { clear = true })

-- reload config file on change
autocmd("BufWritePost", {
  group = "bufcheck",
  pattern = vim.env.MYVIMRC,
  command = "silent source %",
})

-- highlight yanks
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = "bufcheck",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

-- sync clipboards because I'm easily confused
-- autocmd("TextYankPost", {
--   group = "bufcheck",
--   pattern = "*",
--   callback = function()
--     fn.setreg("+", fn.getreg("*"))
--   end,
-- })
--

autocmd("TextYankPost", {
  group = "bufcheck",
  callback = function()
    local reg = vim.v.event.regname
    if reg == "" or reg == "0" then
      fn.setreg("+", fn.getreg('"'))
    end
  end,
})

-- start terminal in insert mode
autocmd("TermOpen", {
  group = "bufcheck",
  pattern = "*",
  command = "startinsert | set winfixheight",
})

-- start git messages in insert mode
autocmd("FileType", {
  group = "bufcheck",
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- pager mappings for Manual
autocmd("FileType", {
  group = "bufcheck",
  pattern = "man",
  callback = function()
    keymap("n", "<enter>", "K", { buffer = true })
    keymap("n", "<backspace>", "<c-o>", { buffer = true })
  end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = "bufcheck",
  pattern = "*",
  callback = function()
    if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
      fn.setpos(".", fn.getpos("'\""))
      -- vcmd("normal zz") -- how do I center the buffer in a sane way??
      vcmd("silent! foldopen")
    end
  end,
})

-- Removes trailing spaces on save
autocmd("BufWritePre", {
  group = "bufcheck",
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Ruff formatter

autocmd("BufWritePre", {
  group = "bufcheck",
  pattern = "*.py",
  callback = function()
    if fn.executable("ruff") == 1 then
      local view = vim.fn.winsaveview()
      vim.cmd("silent! %!ruff format -")
      vim.fn.winrestview(view)
    end
  end,
})

-- Warn about mixed indendation
autocmd({ "BufReadPost", "BufWritePost" }, {
  group = "bufcheck",
  pattern = "*.py",
  callback = function()
    if vim.bo.expandtab == false then
      vim.notify("Python file with tabs?!", vim.log.levels.WARN)
    end
  end,
})

-- Highlight long lines (PEP8 guilt trip)

autocmd("FileType", {
  group = "bufcheck",
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "88"
    vim.opt_local.formatoptions:append("t")
  end,
})

-- Automatically set sane Python buffer options
autocmd("FileType", {
  group = "bufcheck",
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.textwidth = 88
  end,
})

-- Auto-activate virtualenv (if present)

autocmd("VimEnter", {
  group = "bufcheck",
  callback = function()
    local venv = fn.findfile("pyproject.toml", ".;")
    if venv ~= "" then
      vim.env.VIRTUAL_ENV = fn.getcwd() .. "/.venv"
      vim.env.PATH = vim.env.VIRTUAL_ENV .. "/bin:" .. vim.env.PATH
    end
  end,
})

-- Quick feedback after save (lint hint)

autocmd("BufWritePost", {
  group = "bufcheck",
  pattern = "*.py",
  callback = function()
    if fn.executable("ruff") == 1 then
      vim.fn.jobstart({ "ruff", "check", "--quiet", vim.fn.expand("%") })
    end
  end,
})

-- Automatically open folds around cursor (Python blocks!)

autocmd("CursorMoved", {
  group = "bufcheck",
  pattern = "*.py",
  command = "silent! foldopen",
})

-- Never think about directories again.

autocmd("BufWritePre", {
  group = "bufcheck",
  callback = function()
    local dir = fn.fnamemodify(fn.expand("<afile>"), ":p:h")
    if fn.isdirectory(dir) == 0 then
      fn.mkdir(dir, "p")
    end
  end,
})

-- Subtle but clutch: jump to first test failure

autocmd("BufReadPost", {
  group = "bufcheck",
  pattern = "*pytest*.log",
  command = "normal! gg/FAILED<CR>",
})
