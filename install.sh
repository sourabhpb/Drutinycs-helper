#!/bin/bash

# 1. Detect Shell and Configuration File
CURRENT_SHELL=$(basename "$SHELL")
CONFIG_FILE=""

if [[ "$CURRENT_SHELL" == "zsh" ]]; then
    CONFIG_FILE="$HOME/.zshrc"
    echo "🔍 Detected Shell: Zsh (Config: $CONFIG_FILE)"
elif [[ "$CURRENT_SHELL" == "bash" ]]; then
    # MacOS Bash usually uses .bash_profile, Linux uses .bashrc
    if [[ -f "$HOME/.bash_profile" ]]; then
        CONFIG_FILE="$HOME/.bash_profile"
    else
        CONFIG_FILE="$HOME/.bashrc"
    fi
    echo "🔍 Detected Shell: Bash (Config: $CONFIG_FILE)"
else
    echo "❌ Could not detect a supported shell (Zsh or Bash)."
    exit 1
fi

# Get the absolute path of where this repo is cloned
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CMD="source \"$SCRIPT_DIR/drutiny_prompt.sh\""

echo "🔧 Setting up Drutinycs Helper..."
echo "-----------------------------------"

# 2. Update Drutinycs to the latest version (Common for all users)
echo "⬇️  Attempting to update Drutinycs to the latest version..."

# Check if the command exists before trying to run it
if command -v drutinycs &> /dev/null; then
    if drutinycs self-update; then
        echo "✅ Drutinycs updated successfully!"
    else
        echo "⚠️  Automatic update failed."
        echo "👉 Please run 'drutinycs self-update' manually."
    fi
else
    echo "⚠️  'drutinycs' command not found. Skipping update."
fi
echo "-----------------------------------"

# 3. Fix Powerlevel10k Instant Prompt issue (ZSH ONLY)
# We only run this block if the user is on Zsh
if [[ "$CURRENT_SHELL" == "zsh" ]]; then
    if grep -q "POWERLEVEL9K_INSTANT_PROMPT" "$CONFIG_FILE"; then
        echo "ℹ️  Powerlevel10k setting already exists. Skipping."
    else
        # Create a temp file with the setting at the top + original content
        echo "typeset -g POWERLEVEL9K_INSTANT_PROMPT=off" | cat - "$CONFIG_FILE" > temp && mv temp "$CONFIG_FILE"
        echo "✅ Fixed Powerlevel10k instant prompt setting (added to top of .zshrc)."
    fi
fi

# 4. Add the Drutiny script source (Works for both Bash and Zsh)
if grep -q "drutiny_prompt.sh" "$CONFIG_FILE"; then
    echo "ℹ️  Drutiny script is already installed. Skipping."
else
    echo "" >> "$CONFIG_FILE"
    echo "# --- Drutinycs Helper ---" >> "$CONFIG_FILE"
    echo "$SOURCE_CMD" >> "$CONFIG_FILE"
    echo "# ------------------------" >> "$CONFIG_FILE"
    echo "✅ Added Drutiny script to $(basename "$CONFIG_FILE")."
fi

echo ""
echo "🎉 Installation complete! Please restart your terminal."