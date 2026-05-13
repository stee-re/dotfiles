# Tmux Keybindings Cheat Sheet

> **Prefix key:** `Ctrl + a` (instead of the default `Ctrl + b`)
>
> All keybindings below require pressing the **prefix** first, then the key.
> For example, **Prefix → v** means: press `Ctrl + a`, release, then press `v`.

---

## Sessions

| Keybinding    | Action                              |
| ------------- | ----------------------------------- |
| Prefix → `o`  | Open session picker (SessionX, fzf) |
| Prefix → `S`  | Choose a session from a list        |
| Prefix → `^D` | Detach from current session         |
| Prefix → `^A` | Switch to last used window          |

## Windows

| Keybinding    | Action                           |
| ------------- | -------------------------------- |
| Prefix → `^C` | Create a new window (opens in ~) |
| Prefix → `H`  | Go to the **previous** window    |
| Prefix → `L`  | Go to the **next** window        |
| Prefix → `r`  | Rename current window            |
| Prefix → `w`  | List all windows                 |
| Prefix → `"`  | Choose a window interactively    |

> **Tip:** Windows are numbered starting at **1** (not 0).

## Panes

### Creating panes (splits)

| Keybinding   | Action                   |
| ------------ | ------------------------ |
| Prefix → `v` | Split **horizontally** ← \| → |
| Prefix → `s` | Split **vertically** ↑ / ↓    |

### Navigating panes (vim-style)

| Keybinding   | Action     |
| ------------ | ---------- |
| Prefix → `h` | Move left  |
| Prefix → `j` | Move down  |
| Prefix → `k` | Move up    |
| Prefix → `l` | Move right |

### Resizing panes

These are **repeatable** — hold prefix and press the key multiple times within 1.5 s.

| Keybinding   | Action       |
| ------------ | ------------ |
| Prefix → `,` | Shrink left  |
| Prefix → `.` | Grow right   |
| Prefix → `-` | Shrink down  |
| Prefix → `=` | Grow up      |

### Other pane actions

| Keybinding   | Action                                  |
| ------------ | --------------------------------------- |
| Prefix → `z` | **Zoom** (toggle fullscreen for a pane) |
| Prefix → `c` | **Close** (kill) current pane           |
| Prefix → `x` | **Swap** current pane downward          |
| Prefix → `*` | Synchronize panes (type in all at once) |

## Copy Mode (vi-style)

Enter copy mode with `Prefix → [`, then use vim motions to move around.

| Key  | Action                    |
| ---- | ------------------------- |
| `v`  | Start selection           |
| `y`  | Yank (copy) selection     |
| `q`  | Quit copy mode            |

> Yanked text goes to the **system clipboard** automatically (via tmux-yank).

## Floating Window

| Keybinding   | Action                                 |
| ------------ | -------------------------------------- |
| Prefix → `p` | Toggle a floating terminal (80 × 80 %) |

## Utility

| Keybinding   | Action                        |
| ------------ | ----------------------------- |
| Prefix → `R` | **Reload** tmux configuration |
| Prefix → `K` | **Clear** the terminal screen |
| Prefix → `:`  | Open the tmux command prompt  |

## Mouse

Mouse support is **enabled**. You can:

- Click a pane to focus it
- Drag pane borders to resize
- Scroll to browse history

---

## Installed Plugins

| Plugin             | What it does                                   |
| ------------------ | ---------------------------------------------- |
| tmux-sensible      | Sane default settings                          |
| tmux-yank          | Copy to system clipboard                       |
| tmux-resurrect     | Save and restore sessions across restarts      |
| tmux-continuum     | Auto-save sessions periodically                |
| tmux-fzf           | Fuzzy-find tmux objects                        |
| tmux-fzf-url       | Open URLs from the terminal with fzf           |
| tmux-sessionx      | Enhanced session manager (`Prefix → o`)        |
| tmux-floax         | Floating terminal window (`Prefix → p`)        |
| catppuccin (fork)  | Status bar theme (Catppuccin)                  |
