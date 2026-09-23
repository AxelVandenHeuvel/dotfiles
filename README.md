# dotfiles

My macOS config, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```sh
git clone https://github.com/AxelVandenHeuvel/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` installs Homebrew if needed, installs everything in the `Brewfile`, then symlinks each package into `$HOME`.
It is safe to re-run.

## Layout

Each top-level directory is a Stow package whose contents mirror where the files live under `$HOME`.

| Package | Links |
|---|---|
| `zsh` | `~/.zshrc` |
| `git` | `~/.gitconfig`, `~/.config/git/` |
| `tmux` | `~/.config/tmux/` |
| `nvim` | `~/.config/nvim/` |
| `ghostty` | `~/.config/ghostty/` |
| `wezterm` | `~/.config/wezterm/` |
| `gh` | `~/.config/gh/config.yml` |
| `claude` | `~/.claude/settings.json`, `~/.claude/CLAUDE.md` |
| `codex` | `~/.codex/AGENTS.md` (points at the same file as `CLAUDE.md`) |

## Everyday use

Because the files in `$HOME` are symlinks, editing them edits this repo.
Commit from here as usual.

To add a new config, move it into a package with the same relative path, then stow it:

```sh
mkdir -p ~/dotfiles/foo/.config
mv ~/.config/foo ~/dotfiles/foo/.config/
cd ~/dotfiles && stow foo
```

To refresh the `Brewfile` after installing something new, edit it by hand or run `brew bundle dump --file=~/dotfiles/Brewfile --force` and tidy the result.

## Not tracked

Secrets and app-managed state stay out of this repo: `~/.config/gh/hosts.yml`, `~/.claude/settings.local.json`, everything else under `~/.claude` and `~/.codex`, and shell history.
