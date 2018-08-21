#!/bin/bash

## OS detection variables.
# General OS Release file (available in newer OS).
OS_RELEASE_FILE="os-release"
# General OS Release path.
OS_RELEASE_PATH="/etc/$OS_RELEASE_FILE"
# Redhat OS Release file.
REDHAT_RELEASE_FILE="redhat-release"
# General OS Release path.
REDHAT_RELEASE_PATH="/etc/$REDHAT_RELEASE_FILE"
# CentOS OS Release file.
CENTOS_RELEASE_FILE="centos-release"
# General OS Release path.
CENTOS_RELEASE_PATH="/etc/$CENTOS_RELEASE_FILE"
##

## Server info variables.
# Server Architecture
SERVER_ARCH="$(uname -m)"
# OS Type
os_type=""
# OS Relase
os_release=""

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
    #echo "[$(date "+%Y-%m-%d %H:%M:%S")] $2" >> $SCRIPT_LOG_PATH
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

# Function to detect the OS Type and Release.
function detect_os_ver() {
    log "white" "OS version detection started."
    if [[ -f "$OS_RELEASE_PATH" ]]; then
        parse_os_release
        elif [[ -f "$CENTOS_RELEASE_PATH" ]]; then
        parse_centos_release
        elif [[ -f "$REDHAT_RELEASE_PATH" ]]; then
        parse_redhat_release
    fi
}

# Function to parse /etc/os-release file.
function parse_os_release() {
    # OS is of a new variant.
    log "white" "os-release file deteceted."
    os_type="$(grep ID= "$OS_RELEASE_PATH" | grep -v VERSION | awk -F"=" '{print $2}' | tr -d "\"")"
    log "white" "OS Distro is: $os_type"
    os_release="$(grep VERSION_ID "$OS_RELEASE_PATH" | awk -F"=" '{print $2}' | tr -d "\"")"
    log "white" "OS Release is: $os_release"
}

# Function to parse /etc/centos-release file.
function parse_centos_release() {
    # OS is of new CentOS variant.
    log "white" "centos-release file detected."
    os_type="$(awk '{print $1}' "$CENTOS_RELEASE_PATH" | tr '[:upper:]' '[:lower:]')"
    log "white" "OS Distro is: $os_type"
    os_release="$(awk '{print $3}' "$CENTOS_RELEASE_PATH" | awk -F"." '{print $1}')"
    log "white" "OS Release is: $os_release"
}

# Function to parse /etc/redhat-release file.
function parse_redhat_release() {
    # OS is of RHEL variant or old CentOS variant.
    log "white" "redhat-release file detected."
    distro_test="$(awk '{print $1}' "$REDHAT_RELEASE_PATH" | tr '[:upper:]' '[:lower:]')"
    if [[ "$distro_test" = "centos" ]]; then
        os_type=$distro_test
        os_release="$(awk '{print $3}' "$REDHAT_RELEASE_PATH" | awk -F"." '{print $1}')"
    else
        os_type="$(awk '{print $1,$2,$3,$4}' "$REDHAT_RELEASE_PATH" | tr '[:upper:]' '[:lower:]')"
        os_release="$(awk '{print $7}' "$REDHAT_RELEASE_PATH" | awk -F"." '{print $1}')"
    fi
    log "white" "OS Distro is: $os_type"
    log "white" "OS Release is: $os_release"
}

function main() {
    detect_os_ver
}

main "$@"