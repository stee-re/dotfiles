#!/usr/bin/env bash
#
# setup-zsh.sh — prepare a machine so this repo's zsh/.zshrc works.
#
# Mainly installs the zsh plugins that .zshrc sources (autosuggestions +
# syntax-highlighting) into ~/.zsh/plugins, and sanity-checks the external
# tools the config expects. Safe to re-run (idempotent). Works on Linux and
# macOS; uses git clones so no sudo / package manager is required.
#
# Usage:
#   ./setup-zsh.sh            # install/update plugins + report tool status
#   ./setup-zsh.sh --stow     # also back up ~/.zshrc and `stow zsh`
#   ./setup-zsh.sh --chsh     # also offer to set zsh as the default shell

set -euo pipefail

PLUGIN_DIR="$HOME/.zsh/plugins"

# name|repo — extend this list to add more plugins
PLUGINS=(
  "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions.git"
  "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

# Tools referenced by .zshrc. Missing ones are guarded in the config, so these
# are warnings, not errors.
EXPECTED_TOOLS=(zsh starship fzf zoxide yazi nvim git lazygit)

# ---- pretty output -------------------------------------------------------
if [ -t 1 ]; then
  C_OK=$'\033[32m'; C_WARN=$'\033[33m'; C_INFO=$'\033[36m'; C_RST=$'\033[0m'
else
  C_OK=''; C_WARN=''; C_INFO=''; C_RST=''
fi
ok()   { printf '%s✓%s %s\n'  "$C_OK"   "$C_RST" "$*"; }
warn() { printf '%s!%s %s\n'  "$C_WARN" "$C_RST" "$*"; }
info() { printf '%s›%s %s\n'  "$C_INFO" "$C_RST" "$*"; }

DO_STOW=0
DO_CHSH=0
for arg in "$@"; do
  case "$arg" in
    --stow) DO_STOW=1 ;;
    --chsh) DO_CHSH=1 ;;
    -h|--help)
      sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) warn "Unknown argument: $arg" ;;
  esac
done

# ---- 1. require zsh ------------------------------------------------------
if ! command -v zsh >/dev/null 2>&1; then
  warn "zsh is not installed. Install it first, e.g.:"
  warn "    Debian/Ubuntu : sudo apt install zsh"
  warn "    Fedora        : sudo dnf install zsh"
  warn "    macOS         : brew install zsh   (or use the built-in /bin/zsh)"
  exit 1
fi
ok "zsh found: $(command -v zsh)"

# ---- 2. install / update plugins ----------------------------------------
info "Ensuring zsh plugins in $PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR"
for entry in "${PLUGINS[@]}"; do
  name="${entry%%|*}"
  repo="${entry#*|}"
  dest="$PLUGIN_DIR/$name"
  if [ -d "$dest/.git" ]; then
    if git -C "$dest" pull --ff-only --quiet 2>/dev/null; then
      ok "updated $name"
    else
      warn "could not update $name (left as-is)"
    fi
  elif [ -d "$dest" ]; then
    warn "$dest exists but is not a git clone — skipping"
  else
    git clone --depth=1 --quiet "$repo" "$dest"
    ok "cloned $name"
  fi
done

# ---- 3. report on expected external tools -------------------------------
info "Checking tools referenced by .zshrc (missing ones are guarded, not fatal)"
missing=()
for t in "${EXPECTED_TOOLS[@]}"; do
  if command -v "$t" >/dev/null 2>&1; then
    ok "$t"
  else
    warn "$t not found"
    missing+=("$t")
  fi
done
if [ "${#missing[@]}" -gt 0 ]; then
  warn "Optional tools missing: ${missing[*]} — the config degrades gracefully."
fi

# ---- 4. optionally stow the zsh package ---------------------------------
if [ "$DO_STOW" -eq 1 ]; then
  info "Deploying zsh config via stow"
  repo_root="$(cd "$(dirname "$0")" && pwd)"
  if ! command -v stow >/dev/null 2>&1; then
    warn "stow not installed; skipping. Install GNU Stow and re-run with --stow."
  else
    target="$HOME/.zshrc"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      backup="$target.bak.$(date +%Y%m%d%H%M%S)"
      mv "$target" "$backup"
      ok "backed up existing ~/.zshrc → $backup"
    fi
    ( cd "$repo_root" && stow --restow zsh )
    ok "stowed zsh"
  fi
fi

# ---- 5. optionally set zsh as the default shell -------------------------
if [ "$DO_CHSH" -eq 1 ]; then
  zsh_path="$(command -v zsh)"
  if [ "${SHELL:-}" = "$zsh_path" ]; then
    ok "default shell already zsh"
  else
    info "Setting default shell to $zsh_path (you may be prompted for your password)"
    if ! grep -qxF "$zsh_path" /etc/shells 2>/dev/null; then
      warn "$zsh_path is not in /etc/shells; chsh may refuse it."
      warn "Add it with: echo '$zsh_path' | sudo tee -a /etc/shells"
    fi
    if chsh -s "$zsh_path"; then
      ok "default shell changed to zsh — log out and back in to take effect"
    else
      warn "chsh failed; change it manually if desired"
    fi
  fi
fi

echo
ok "zsh setup complete."
info "Open a new zsh session to verify: autosuggestions, syntax highlighting,"
info "Ctrl-R (fzf), and Ctrl-f (zoxide) should all work."
