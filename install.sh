#!/bin/bash

CONFIG_FILE="$HOME/.zshrc"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CMD="source $SCRIPT_DIR/drutiny_prompt.sh"

# 1. Fix Powerlevel10k Instant Prompt issue (Prepend to top)
if grep -q "POWERLEVEL9K_INSTANT_PROMPT" "$CONFIG_FILE"; then
    echo "P10k setting already exists. Skipping."
else
    # Create a temp file to prepend the setting
    echo "typeset -g POWERLEVEL9K_INSTANT_PROMPT=off" | cat - "$CONFIG_FILE" > temp && mv temp "$CONFIG_FILE"
    echo "✅ Fixed Powerlevel10k instant prompt setting."
fi

# 2. Add the Drutiny script (Append to bottom)
if grep -q "drutiny_prompt.sh" "$CONFIG_FILE"; then
    echo "Drutiny script is already installed."
else
    echo "" >> "$CONFIG_FILE"
    echo "# Drutiny Support Tool" >> "$CONFIG_FILE"
    echo "$SOURCE_CMD" >> "$CONFIG_FILE"
    echo "✅ Added Drutiny script to zshrc."
fi

echo "🎉 Installation complete! Please restart your terminal."
