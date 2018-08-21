#!/bin/bash

## Color Variables
# NC (No Color)
NC='\033[0m'
# Red
RED='\033[1;31m'
# Yellow
YELLOW='\033[1;33m'
# Green
GREEN='\033[1;32m'

# Logs script messages to file with timestamp.
function log() {
    case "$1" in
        red)
            echo -e "${RED}[$(date "+%Y-%m-%d %H:%M:%S")] $2${NC}"
        ;;
        green)
            echo -e "${GREEN}[$(date "+%Y-%m-%d %H:%M:%S")] $2${NC}"
        ;;
        yellow)
            echo -e "${YELLOW}[$(date "+%Y-%m-%d %H:%M:%S")] $2${NC}"
        ;;
        *)
            echo -e "${NC}[$(date "+%Y-%m-%d %H:%M:%S")] $2${NC}"
        ;;
    esac
}

# Function to check that the user running the script is root.
function check_root {
    if [[ $EUID -ne 0 ]]; then
        log "red" "This script must be run as root"
    else
        log "green" "You are root"
    fi
}

# Main script function
function main() {
    # Checking that user running the script is root.
    check_root
}

main "$@"