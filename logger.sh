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

## Script logging variables.
# Log file name.
SCRIPT_LOG_FILE="my-log-file.log"
# Log file path.
SCRIPT_LOG_PATH="/path/to/log/$SCRIPT_LOG_FILE"

# Logs script messages to file with timestamp.
function log() {
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $2" >> $SCRIPT_LOG_PATH
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

function main() {
    # Checking if script log file exists and if not creating a new one.
    # Note this command will fail if the rest of the path doesn't exist
    if [[ ! -f "$SCRIPT_LOG_PATH" ]]; then
        touch "$SCRIPT_LOG_PATH"
    else
        # A script log file exists, which means it has been run before.
        log "yellow" "Script was run before."
    fi
    
    log "white" "example normal message"
    log "yellow" "example warning message"
    log "red" "example error message"
}

main "$@"