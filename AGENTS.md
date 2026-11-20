# dotfiles

Personal Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's here

| Directory     | What it configures          |
|---------------|-----------------------------|
| `bash/`       | `.bashrc`, `.bash_profile`  |
| `zsh/`        | `.zshrc`                    |
| `nvim/`       | Neovim (`~/.config/nvim`)   |
| `tmux/`       | tmux (`~/.config/tmux`)     |
| `starship/`   | Starship prompt             |
| `markdownlint/` | markdownlint config       |
| `agents/`     | AI/agent tooling config     |

## Usage

```bash
stow bash        # link bash dotfiles
stow nvim        # link neovim config
stow tmux        # link tmux config
# ... etc for each package
```

## Notes

- `.stow-local-ignore` excludes `.git`, `.gitignore`, `.vscode`, `README.md`, and `LICENSE` from stow.
- tmux plugins dir is gitignored (managed externally via TPM).
