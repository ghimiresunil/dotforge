-- =============================================================================
-- claude.lua — Complete Claude Code Integration for Neovim
-- Plugin : coder/claudecode.nvim
-- Docs   : https://github.com/coder/claudecode.nvim
-- Place  : ~/.config/nvim/lua/plugins/claude.lua
-- =============================================================================

return {
  "coder/claudecode.nvim",

  -- ── Dependencies ────────────────────────────────────────────────────────────
  dependencies = {
    "folke/snacks.nvim", -- enhanced terminal (floating, tabs, etc.)
  },

  -- ── Lazy-load on these commands ──────────────────────────────────────────────
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSend",
    "ClaudeCodeAdd",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeSelectModel",
    "ClaudeCodeStatus",
  },

  -- ── Keymaps ──────────────────────────────────────────────────────────────────
  -- All under <leader>a so they show as a group in which-key.
  keys = {
    { "<leader>a", nil, desc = "AI / Claude" },

    -- ── Open / focus ───────────────────────────────────────────────────────────
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude", mode = { "n" } },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude", mode = { "n", "x" } },

    -- ── Session management ─────────────────────────────────────────────────────
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume last session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last session" },

    -- ── Model picker ───────────────────────────────────────────────────────────
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },

    -- ── Context: send / add ────────────────────────────────────────────────────
    -- Send visual selection as context
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send selection → Claude", mode = "v" },
    -- Add current buffer to Claude context
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    -- Add file under cursor in a file explorer (nvim-tree / neo-tree / oil / mini / netrw)
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file (explorer)",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },

    -- ── Diff management ────────────────────────────────────────────────────────
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

    -- ── Status / debug ─────────────────────────────────────────────────────────
    { "<leader>aS", "<cmd>ClaudeCodeStatus<cr>", desc = "Claude status" },
  },

  -- ── Plugin options (all keys verified from official docs) ───────────────────
  opts = {

    -- ── Server ────────────────────────────────────────────────────────────────
    port_range = { min = 10000, max = 65535 }, -- random port in this range
    auto_start = true, -- start WebSocket server on Neovim launch
    log_level = "info", -- "trace"|"debug"|"info"|"warn"|"error"

    -- Path to the Claude CLI binary.
    -- nil   → uses "claude" from $PATH (works for global npm installs)
    -- Set this if you used `claude migrate-installer`:
    --   terminal_cmd = "~/.claude/local/claude"
    -- Or for native binary, paste output of `which claude`:
    --   terminal_cmd = "/home/you/.claude/local/claude"
    terminal_cmd = nil,

    -- ── Send / focus behaviour ─────────────────────────────────────────────────
    -- When true, <leader>as will also focus the Claude window after sending.
    focus_after_send = false,

    -- ── Selection tracking ─────────────────────────────────────────────────────
    -- Continuously streams your current selection/cursor to Claude so it always
    -- has live context without you having to explicitly send anything.
    track_selection = true,
    visual_demotion_delay_ms = 50, -- ms before a visual selection is "demoted" to cursor

    -- ── Terminal ───────────────────────────────────────────────────────────────
    terminal = {
      -- provider: "auto" | "snacks" | "native" | "external" | "none"
      --   auto   → snacks if available, else native  ← recommended
      --   native → Neovim built-in :terminal
      --   none   → no UI; run `claude --ide` yourself in an external terminal
      provider = "auto",

      split_side = "right", -- "left" | "right"
      split_width_percentage = 0.35, -- fraction of editor width (0.0–1.0)
      auto_close = true, -- close window when Claude exits

      -- ── Floating window (snacks only) ──────────────────────────────────────
      -- Uncomment to use a centered float instead of a side split:
      -- snacks_win_opts = {
      --   position = "float",
      --   width    = 0.85,
      --   height   = 0.85,
      --   border   = "rounded",
      -- },

      -- ── Working-directory control ──────────────────────────────────────────
      -- Option A – static path:
      -- cwd = vim.fn.expand("~/projects/my-app"),
      --
      -- Option B – dynamic via function (e.g. always use git root):
      -- cwd_provider = function(ctx)
      --   return require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd)
      --     or ctx.file_dir or ctx.cwd
      -- end,
    },

    -- Top-level shorthand: resolve Claude's cwd to the git repo root.
    -- Equivalent to setting terminal.cwd_provider to the built-in git-root helper.
    git_repo_cwd = true,

    -- ── Diff integration ───────────────────────────────────────────────────────
    diff_opts = {
      layout = "vertical", -- "vertical" | "horizontal"
      open_in_new_tab = false, -- open diff in a new tab instead of current
      keep_terminal_focus = false, -- move focus back to terminal after diff opens
    },
  },

  -- ── Extra setup ──────────────────────────────────────────────────────────────
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- ── Custom user commands ───────────────────────────────────────────────────

    -- :ClaudeAsk [question]
    -- Quick one-shot prompt; opens vim.ui.input if no argument given.
    vim.api.nvim_create_user_command("ClaudeAsk", function(args)
      local prompt = args.args
      if prompt == "" then
        vim.ui.input({ prompt = "Ask Claude: " }, function(input)
          if input and input ~= "" then
            vim.cmd("ClaudeCode " .. vim.fn.shellescape(input))
          end
        end)
      else
        vim.cmd("ClaudeCode " .. vim.fn.shellescape(prompt))
      end
    end, { nargs = "?", desc = "Ask Claude (prompt)" })

    -- :ClaudeFile
    -- Adds the current buffer to Claude's context and opens the terminal.
    vim.api.nvim_create_user_command("ClaudeFile", function()
      local file = vim.fn.expand("%:p")
      if file == "" then
        vim.notify("[Claude] No file open", vim.log.levels.WARN)
        return
      end
      vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(file))
      vim.cmd("ClaudeCode")
    end, { desc = "Add current file to Claude and open" })

    -- ── Autocommands ───────────────────────────────────────────────────────────
    local group = vim.api.nvim_create_augroup("ClaudeCodeUser", { clear = true })

    -- Reload any buffer Claude edited on disk while Neovim was in background.
    vim.api.nvim_create_autocmd("FocusGained", {
      group = group,
      desc = "Sync buffers Claude may have changed",
      callback = function()
        vim.cmd("checktime")
      end,
    })
  end,
}

-- =============================================================================
-- QUICK-START
-- =============================================================================
--
-- 1. Install the CLI (requires Node.js 18+):
--      npm install -g @anthropic-ai/claude-code
--
--    OR use the native binary installer:
--      curl -fsSL https://claude.ai/install.sh | bash
--
-- 2. Add your API key to ~/.zshrc or ~/.bashrc:
--      export ANTHROPIC_API_KEY="sk-ant-..."
--
-- 3. Drop this file at:
--      ~/.config/nvim/lua/plugins/claude.lua
--
-- 4. Run :Lazy sync, then restart Neovim.
--
-- 5. Open a project and press <leader>ac.
--
-- ─────────────────────────────────────────────────────────────────────────────
-- KEYBINDINGS
-- ─────────────────────────────────────────────────────────────────────────────
--  <leader>ac   Toggle Claude terminal
--  <leader>af   Focus Claude (smart: open if closed, focus if open)   [n, x]
--  <leader>ar   Resume most-recent session
--  <leader>aC   Continue last session (no session picker)
--  <leader>am   Pick Claude model then open
--  <leader>ab   Add current buffer to Claude context
--  <leader>as   Send visual selection → Claude                        [v]
--  <leader>as   Add file under cursor (in file explorer)
--  <leader>aa   Accept Claude diff   (also: :w inside the diff)
--  <leader>ad   Deny Claude diff     (also: :q inside the diff)
--  <leader>aS   Show connection status / debug info
--
-- ─────────────────────────────────────────────────────────────────────────────
-- CUSTOM COMMANDS
-- ─────────────────────────────────────────────────────────────────────────────
--  :ClaudeAsk [prompt]   One-shot question (UI prompt if no arg given)
--  :ClaudeFile           Add current file to context and open Claude
--
-- ─────────────────────────────────────────────────────────────────────────────
-- TROUBLESHOOTING
-- ─────────────────────────────────────────────────────────────────────────────
--  Not connecting?        :ClaudeCodeStatus — check lock file in ~/.claude/ide/
--  Error 127?             set terminal_cmd = "/full/path/from/which claude"
--  Debug logs?            set log_level = "debug"
--  Terminal glitchy?      set provider = "native"
--  Used migrate-installer? set terminal_cmd = "~/.claude/local/claude"
-- =============================================================================
