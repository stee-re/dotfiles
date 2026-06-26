# `setup-zsh.sh`

Prepares a machine so this repo's [`zsh/.zshrc`](zsh/.zshrc) works correctly —
chiefly by installing the zsh plugins the config sources, and sanity-checking
the external tools it expects.

It is **idempotent** (safe to re-run), **cross-platform** (Linux + macOS), and
needs **no `sudo`** — plugins are installed via shallow `git` clones into your
home directory.

## Usage

```sh
./setup-zsh.sh            # install/update plugins + report tool status
./setup-zsh.sh --stow     # also back up ~/.zshrc and `stow zsh`
./setup-zsh.sh --chsh     # also offer to set zsh as the default shell
./setup-zsh.sh --help     # show usage
```

Flags can be combined (e.g. `./setup-zsh.sh --stow --chsh`). With no flags the
script only touches `~/.zsh/plugins` — it never modifies your shell or `~/.zshrc`.

## What it does

1. **Checks that `zsh` is installed.** If not, it prints install hints for
   apt/dnf/brew and exits.

2. **Installs / updates the zsh plugins** that `.zshrc` sources, into
   `~/.zsh/plugins/`:
   - [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) —
     fish-style command suggestions from history.
   - [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) —
     live command-line syntax colouring (sourced **last** in `.zshrc`, as it
     requires).

   On first run it clones them; on later runs it `git pull --ff-only`s. The
   plugin list lives in a single array near the top of the script, so adding
   another plugin is a one-line change.

3. **Reports on the external tools** `.zshrc` references (`starship`, `fzf`,
   `zoxide`, `yazi`, `nvim`, `git`, `lazygit`, …). Missing tools are **warnings,
   not errors** — the config guards every one of them and degrades gracefully.

### Optional steps (opt-in via flags)

4. **`--stow`** — deploys the config. If `~/.zshrc` exists as a real file (not a
   symlink), it is moved aside to a timestamped backup
   (`~/.zshrc.bak.YYYYmmddHHMMSS`), then `stow zsh` symlinks the repo's version
   into place. This resolves the common "existing target is neither a link nor a
   directory" stow conflict.

5. **`--chsh`** — offers to set zsh as your login shell. It checks that the zsh
   path is listed in `/etc/shells` first (and tells you how to add it if not).
   Takes effect after the next log out / log in.

## Why plugins live in `~/.zsh/plugins`

`.zshrc` looks for each plugin in three locations, in order, and sources the
first it finds:

1. `~/.zsh/plugins/<name>/<name>.zsh`  ← what this script populates
2. Homebrew's share path (macOS)
3. the apt/system share path (Linux)

The git-clone approach (1) works identically on every machine without a package
manager, which is why the script targets it. If you already get a plugin from
brew or apt, the config will happily use that copy instead.

## After running

Open a **new** zsh session and confirm:

- type a previously-used command → greyed-out **autosuggestion** appears
- a valid command shows green, an unknown one red → **syntax highlighting**
- **`Ctrl-R`** → fzf fuzzy history search
- **`Ctrl-f`** → zoxide interactive `cd`
- **`y`** → opens yazi; quitting `cd`s to the directory you were browsing
- **`Esc`** then `h`/`j`/`k`/`l` → **vi keybindings** on the command line

## Related

- [`zsh/.zshrc`](zsh/.zshrc) — the config this script supports.
- [`bash/.bashrc`](bash/.bashrc) — the bash equivalent (parity reference).
- Deploying everything else: `stow -R <package>` from the repo root.
