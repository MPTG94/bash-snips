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

function parse_script_options() {
    # Parsing input parameters from script call
    # NOTE: in order to force a flag to expect an argument, add a colon(:) after it
    # To access the value of the argument use the variable $OPTARG
    while getopts k:b:ihs option
    do
        case "${option}"
            in
            k)
                log "white" "flag: -${option} was provided with value: $OPTARG"
            ;;
            b)
                log "white" "flag: -${option} was provided with value: $OPTARG"
            ;;
            i)
                log "white" "flag: -${option} was provided"
            ;;
            s)
                log "white" "flag: -${option} was provided"
            ;;
            h)
                log "white" "flag: -${option} was provided"
            ;;
            *)
        esac
    done
}

function main() {
    parse_script_options "$@"
}

main "$@"

# example script call: bash script-flags.sh -k foo -b bar -i -h -s