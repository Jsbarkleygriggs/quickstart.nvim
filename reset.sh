#!/bin/bash

# Paths to Neovim config and backup locations
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA="$HOME/.local/share/nvim"
NVIM_BACKUP="$HOME/.config/nvim-backup-$(date +%Y%m%d-%H%M%S)"
NVIM_DATA_BACKUP="$HOME/.local/share/nvim-backup-$(date +%Y%m%d-%H%M%S)"

# Backup current configuration
echo "Backing up current Neovim config to $NVIM_BACKUP and $NVIM_DATA_BACKUP"
if [ -d "$NVIM_CONFIG" ]; then
    mv "$NVIM_CONFIG" "$NVIM_BACKUP"
fi
if [ -d "$NVIM_DATA" ]; then
    mv "$NVIM_DATA" "$NVIM_DATA_BACKUP"
fi

# Create a fresh config directory
echo "Creating fresh Neovim config directory"
mkdir -p "$NVIM_CONFIG"

# Clone the kickstart.nvim repository
echo "Cloning kickstart.nvim configuration"
git clone https://github.com/Jsbarkleygriggs/kickstart.nvim.git "$NVIM_CONFIG"

# Final message
echo "Neovim reset complete. Kickstart.nvim configuration has been cloned!"
