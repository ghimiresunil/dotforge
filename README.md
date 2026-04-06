# dotforge

My handcrafted development & system environment — managed with Ansible, structured for reproducibility.

## What's inside

| Category | Tools |
|---|---|
| **Editor** | Neovim (Lua, LSP, lazy.nvim) |
| **Shell** | Bash, Starship prompt, tmux |
| **Terminal** | Alacritty |
| **Window Manager** | i3, Openbox |
| **Status Bar** | Polybar |
| **Launcher** | Rofi |
| **Compositor** | Picom |
| **Notes** | Obsidian |
| **Dev Tools** | pyenv, nvm, Docker, fzf, bat |
| **Scripts** | brightness, volume, monitors, pomodoro, lockscreen, and more |

## Quickstart

### Prerequisites

```bash
sudo apt install ansible git
```

### Deploy everything

```bash
cd playbook
make deploy
```

### Dry run (no changes)

```bash
make dryrun
```

### Install applications only

```bash
make apps
```

The playbook runs three roles in order:

1. **common** — installs base packages (git, tmux, ripgrep, zsh, curl, etc.)
2. **applications** — installs Neovim, Node.js, Python, Docker, Brave, VS Code, Zoom, fzf
3. **dotfiles** — symlinks all configs to their expected locations

## Structure

```
dotforge/
├── nvim/           # Neovim config (Lua-based)
├── tmux/           # Tmux config
├── bashrc/         # Bash + Starship + aliases
├── alacritty/      # Terminal emulator config
├── i3/             # i3 window manager
├── polybar/        # Status bar
├── rofi/           # App launcher
├── picom/          # Compositor
├── openbox/        # Openbox WM
├── wlogout/        # Logout menu
├── autorandr/      # Multi-monitor profiles
├── bat/            # bat (cat replacement) config
├── obsidian/       # Obsidian vault config
├── scripts/        # Utility shell scripts
├── programming/    # Pre-commit hook templates
├── playbook/       # Ansible automation
└── docs/           # Setup and deployment guides
```

## Neovim

Lua-based config with lazy.nvim. Highlights:

- LSP (Python, Lua) with auto-completion (nvim-cmp)
- Treesitter syntax highlighting
- Telescope fuzzy finder
- NvimTree file explorer
- Lualine status line
- DAP debugger
- Neorg for notes

See [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) for keybindings and full plugin list.

## Scripts

Located in `scripts/.scripts/`:

| Script | Purpose |
|---|---|
| `monitors.sh` | Multi-monitor management |
| `brightness.sh` | Screen brightness |
| `volume.sh` | Audio control |
| `lockscreen.sh` | Screen lock |
| `pomodoro.sh` | Pomodoro timer |
| `calendar.sh` | Calendar popup |
| `dev-tmux.sh` | Dev tmux session setup |
| `kb-light.py` | Keyboard backlight |
| `mic-status.sh` | Microphone status |
| `screenshot_obsidian.sh` | Screenshot → Obsidian |

## Author

[Sunil Ghimire](https://github.com/ghimiresunil)
