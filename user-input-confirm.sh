## Script Variables
# User answer for input confirmation.
answer=""
# Result of use answer
answer_result=false

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

# Function to get and parse answer from user if the input information is correct.
function confirm_input() {
    echo "Is this okay? (yes/no)"
    read answer
    
    answer="$(echo "$answer" | tr '[:upper:]' '[:lower:]')"
}

function get_user_confirmation() {
    confirm_input
    confirm=0
    while [[ "$confirm" -ne 1 ]]; do
        case $answer
            in
            y)
                confirm=1
                answer_result=true
            ;;
            yes)
                confirm=1
                answer_result=true
            ;;
            n)
                confirm=1
                answer_result=false
            ;;
            no)
                confirm=1
                answer_result=false
            ;;
            *)
                echo "Invalid Input, please use yes or no"
                confirm_input
        esac
    done
}

function main() {
    get_user_confirmation
    
    log "white" "User answer is: $answer_result"
}

main "$@"