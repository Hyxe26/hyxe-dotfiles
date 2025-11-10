#!/usr/bin/env bash

# Exit on error
set -e

# Go to the script directory (assumes dotfiles are here)
cd "$(dirname "$0")" || exit 1

# List of modules to stow (folders in dotfiles/)
MODULES=(
  waybar
  hypr
  kitty
  zsh
  # Add more modules here
)

echo "🗂 Starting dotfiles installation..."
echo

for module in "${MODULES[@]}"; do
    echo "🔧 Processing $module..."

    # First, stow the module safely
    stow -v --target="$HOME" --restow "$module"
    echo "   ✅ Module $module symlinked successfully."

    # Then, remove any pre-existing files/folders in $HOME that were replaced by the symlinks
    for target in $(find "$module" -type f -o -type d); do
        rel_path="${target#$module/}"
        dest="$HOME/$rel_path"

        # If a regular file/folder exists at the destination that is not a symlink, remove it
        if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            rm -rf "$dest"
            echo "   🗑 Removed original $dest"
        fi
    done

    echo
done

echo "✅ All dotfiles linked and old configs cleaned!"
