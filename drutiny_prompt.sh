#!/bin/bash

# Prevent the script from running if not in an interactive shell
[[ $- != *i* ]] && return

# 1. Check if "drutinycs" is already running in any window
# The -f flag matches the command line name
if pgrep -f "drutinycs" > /dev/null; then
  # Optional: Print nothing, or a small checkmark
  # echo "✅ drutiny check running in background..."
  : # Do nothing
else
  # 2. If NOT running, ask the user
  echo "Welcome back! 👋"
  echo "Would you like to run 'drutinycs wap' now? (y/n)"
  read -r response

  if [[ "$response" == "y" ]]; then
    echo "🚀 Starting drutinycs wap..."
    # Assuming drutinycs is in the global PATH.
    drutinycs wap
  else
    echo "Okay thanks, no worries! But please do run this later, as this will help to generate the autopanic report."
  fi
fi