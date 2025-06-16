#!/bin/bash
# lets a user restart t2fanrd service with a given config file.
use_fan_config() {
    local config_name="$1"
    local source_file="/etc/t2fanrd/$config_name"
    local target_file="/etc/t2fand.conf"

    if [[ -z "$config_name" ]]; then
        echo "Usage: use_fan_config <filename.conf>"
        return 1
    fi

    if [[ "$config_name" != *.conf ]]; then
        echo "Error: Filename must end with .conf"
        return 1
    fi

    if [[ ! -f "$source_file" ]]; then
        echo "Error: File '$source_file' does not exist."
        return 1
    fi

    if ! sudo cp "$source_file" "$target_file"; then
        echo "Error: Failed to copy file."
        return 1
    fi

    if ! sudo systemctl restart t2fanrd; then
        echo "Error: Failed to restart t2fanrd."
        return 1
    fi

    echo "Config '$config_name' applied and t2fanrd restarted."
}

_use_fan_config_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -W "$(basename -a /etc/t2fanrd/*.conf 2>/dev/null)" -- "$cur"))
}

