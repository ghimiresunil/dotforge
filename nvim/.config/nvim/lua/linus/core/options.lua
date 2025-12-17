-- core system paths (used for undodir)
local system = require("linus.core.system") -- replace with local cache_dir = vim.fn.stdpath("cache") if needed
local opt = vim.opt -- shorthand

-- General
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.hidden = true -- Allow background buffers
opt.errorbells = true -- Enable error bells
opt.visualbell = true -- Use visual bell instead of beeping
opt.magic = true -- Enable magic for regex
opt.termguicolors = true -- Enable true color support
opt.background = "dark" -- Set background for theme compatibility
opt.syntax = "on" -- Enable syntax highlighting
opt.history = 2000 -- Command history limit
opt.updatetime = 200 -- Faster completion and updates (important for plugins)
opt.redrawtime = 1500 -- Increase redraw time for large files
opt.timeout = true -- Enable key timeout
opt.timeoutlen = 300 -- Time to wait for mapped sequence (ms)
opt.ttimeout = true -- Enable terminal key timeout
opt.ttimeoutlen = 0 -- Fast keycode recognition
opt.scrolloff = 2 -- Minimal lines to keep above/below cursor
opt.sidescrolloff = 5 -- Minimal columns to keep left/right of cursor
opt.signcolumn = "yes" -- Always show sign column
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don’t show -- INSERT -- etc.
opt.showcmd = true -- Show (partial) command in last line
opt.ruler = true -- Show cursor position
opt.mouse = "a" -- Enable mouse in all modes

-- Line numbers
opt.relativenumber = true -- Show relative line numbers
opt.number = true -- Show absolute number on current line

-- Tabs & indentation
opt.tabstop = 4 -- Number of spaces per tab
opt.shiftwidth = 4 -- Number of spaces for each indent
opt.expandtab = true -- Use spaces instead of tabs
opt.autoindent = true -- Auto-indent new lines
opt.smarttab = true -- Use shiftwidth for tab at start of line
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Line wrapping
opt.wrap = false -- Enable line wrapping
opt.linebreak = true -- Wrap at word boundaries
opt.breakindentopt = "shift:2,min:20" -- Control wrapped line indenting

-- Cursor
opt.cursorline = true -- Highlight current line
opt.cursorcolumn = false -- Highlight current column
opt.guicursor = { -- Cursor shapes in different modes
	"n-v-c:block",
	"i-ci:ver25",
	"r-cr:hor20",
	"o:hor20",
}

-- Searching
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if uppercase is used
opt.incsearch = true -- Show match while typing
opt.wrapscan = true -- Wrap around end of file in search
opt.infercase = true -- Smart case for keyword completion
opt.inccommand = "nosplit" -- Live preview of :%s substitutions

-- Completion
opt.complete = ".,w,b,k,kspell" -- Completion sources
opt.completeopt = "menuone,noselect,popup" -- Completion behavior
opt.pumheight = 15 -- Max number of popup menu items
opt.pumblend = 0 -- Transparency of popup menu

-- Splits
opt.splitright = true -- Vertical splits to the right
opt.splitbelow = true -- Horizontal splits below
opt.splitkeep = "screen" -- Maintain visual screen context on split
opt.winminwidth = 10 -- Minimum window width
opt.winwidth = 30 -- Preferred minimum window width

-- File handling
opt.autoread = true -- Reload files changed outside vim
opt.autowrite = true -- Auto save before :next, :make, etc.
opt.backup = false -- Disable backup files
opt.swapfile = false -- Disable swap files
opt.writebackup = false -- Disable backup before overwriting
opt.undofile = true -- Enable persistent undo
opt.undodir = system.cache_dir .. "/undo/" -- Undo directory path
-- opt.undodir = vim.fn.stdpath("cache") .. "/undo/" -- Use if not using core.system
opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim" -- Don't backup temp files
opt.fileformats = "unix,mac,dos" -- Supported file formats

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default

-- Diff & Grep
opt.diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience" -- Better diff settings
opt.grepformat = "%f:%l:%c:%m" -- Grep output format
opt.grepprg = "rg --hidden --vimgrep --smart-case --" -- Use ripgrep

-- UI Enhancements
opt.list = true -- Show invisible characters
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←" -- Symbols for invisible chars
opt.showbreak = "↳  " -- Wrap symbol
opt.foldenable = true -- Enable code folding
opt.foldlevelstart = 99 -- Open all folds by default
opt.shortmess = "aoOTIcF" -- Avoid extra messages
opt.viewoptions = "folds,cursor,curdir,slash,unix" -- Saved view settings
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize" -- Session save options
opt.shada = "!,'500,<50,@100,s10,h" -- Session data save options
opt.synmaxcol = 2500 -- Max column for syntax highlighting
opt.winblend = 0 -- Window transparency

-- Navigation
opt.jumpoptions = "stack" -- Use jump stack for navigation
opt.startofline = false -- Don’t reset cursor column on movement
opt.switchbuf = "usetab,uselast" -- Buffer switching behavior

-- Backspace
opt.backspace = "indent,eol,start" -- Allow backspace over autoindent, EOL, and insert start

-- Wildmenu
opt.wildignore =
	".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**" -- Ignore these files/folders
opt.wildignorecase = true -- Case-insensitive wildignore

-- Netrw (file explorer)
vim.cmd("let g:netrw_liststyle = 3") -- Use tree-style listing in netrw

vim.cmd([[
  augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver1-blinkon100-blinkoff100-blinkwait100
  augroup END
]])

-- Remove ~ on first open + globally
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.opt.fillchars:append("eob: ")
	end,
})
