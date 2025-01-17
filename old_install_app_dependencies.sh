#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Ensure the script is run from the scripts directory directly
SCRIPT_DIR_NAME="scripts"
CURRENT_DIR_NAME=$(basename "$PWD")

if [ "$CURRENT_DIR_NAME" != "$SCRIPT_DIR_NAME" ]; then
    echo "This script must be run from the $SCRIPT_DIR_NAME directory."
    exit 1
fi

# Array of scripts to execute
SCRIPTS=(
    "old_postgres_and_go.sh"
    "old_postgres_setup.sh"
    "old_nginx.sh"
    "old_certbot_config.sh"
)

# Make all scripts executable and execute them
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        echo "Executing $script..."
        ./"$script"
    else
        echo "Script $script does not exist."
        exit 1
    fi
done