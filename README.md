# Drutinycs-helper

# Support Team Shell Tools 🛠️

This repository contains terminal automation scripts designed to help the Support Team generate **Autopanic Reports** consistently.

## 🚀 Features

* **Smart Prompt:** Asks if you want to run `drutinycs wap` immediately upon opening a new terminal.
* **Conflict Aware:** Uses `pgrep` to detect if the command is already running in another tab/window so it won't annoy you with duplicate prompts.
* **Zsh & Powerlevel10k Compatible:** Includes fixes for "Instant Prompt" warnings.

## 📥 Installation

1.  Clone this repository to your home folder (or anywhere you prefer):
    ```bash
    git clone [https://github.com/YOUR_ORG/support-shell-tools.git](https://github.com/YOUR_ORG/support-shell-tools.git) ~/support-shell-tools
    ```

2.  Run the installer script:
    ```bash
    cd ~/support-shell-tools
    bash install.sh
    ```

3.  Restart iTerm.

## 🤔 How it works

Once installed, your `.zshrc` file will source the script in this repo.
1.  **On Startup:** It checks if `drutinycs` is running.
2.  **If Running:** It stays silent (prints a small checkmark).
3.  **If Not Running:** It asks: `Would you like to run 'drutinycs wap' now? (y/n)`
    * **Yes:** Runs the command immediately.
    * **No:** Reminds you to run it later for the Autopanic Report.

## 🔄 Updating

If we update the script, just pull the latest changes:
```bash
cd ~/support-shell-tools
git pull
