#!/usr/bin/env bash
# Bootstrap a Mac from this repo: install Homebrew + Brewfile, then symlink every package with GNU Stow.
# Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle --file="$DOTFILES/Brewfile"

# --- Agent CLIs (official self-updating installers, into ~/.local/bin) ---
if [ ! -x "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
if [ ! -x "$HOME/.local/bin/codex" ]; then
  curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
fi

# --- Symlinks ---
# Directories that apps also write state or credentials into must exist as real directories first.
# Otherwise stow would symlink the whole directory and that state would land in this repo.
mkdir -p "$HOME/.config/gh" "$HOME/.claude" "$HOME/.codex"

cd "$DOTFILES"
for pkg in */; do
  stow --restow --target="$HOME" "${pkg%/}"
done

echo "Done. Open a new shell to pick up the changes."
