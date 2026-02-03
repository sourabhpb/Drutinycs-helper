#!/bin/bash

CONFIG_FILE="$HOME/.zshrc"
# Get the absolute path of where this repo is cloned
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CMD="source \"$SCRIPT_DIR/drutiny_prompt.sh\""

echo "🔧 Setting up Drutinycs Helper..."
echo "-----------------------------------"

# 1. Update Drutiny to the latest version
echo "⬇️  Attempting to update Drutiny to the latest version..."
if drutinycs self-update; then
    echo "✅ Drutiny updated successfully!"
else
    echo "⚠️  Automatic update failed."
    echo "👉 Please run 'drutiny self-update' manually to ensure you have the latest features."
fi
echo "-----------------------------------"

# 2. Fix Powerlevel10k Instant Prompt issue (Must be at the TOP of .zshrc)
if grep -q "POWERLEVEL9K_INSTANT_PROMPT" "$CONFIG_FILE"; then
    echo "ℹ️  Powerlevel10k setting already exists. Skipping."
else
    # Create a temp file with the setting at the top + original content
    echo "typeset -g POWERLEVEL9K_INSTANT_PROMPT=off" | cat - "$CONFIG_FILE" > temp && mv temp "$CONFIG_FILE"
    echo "✅ Fixed Powerlevel10k instant prompt setting (added to top of .zshrc)."
fi

# 3. Add the Drutiny script source (Must be at the BOTTOM of .zshrc)
if grep -q "drutiny_prompt.sh" "$CONFIG_FILE"; then
    echo "ℹ️  Drutiny script is already installed. Skipping."
else
    echo "" >> "$CONFIG_FILE"
    echo "# --- Drutinycs Helper ---" >> "$CONFIG_FILE"
    echo "$SOURCE_CMD" >> "$CONFIG_FILE"
    echo "# ------------------------" >> "$CONFIG_FILE"
    echo "✅ Added Drutiny script to .zshrc."
fi

echo ""
echo "🎉 Installation complete! Please restart your terminal."