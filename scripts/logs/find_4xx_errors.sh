#!/bin/bash
# Script to find errors of type 4XX in NGINX log files
# Print the unique IP addresses that have got 4XX errors
# Print the IP address, number of times it appeared
# Print in descending order by count of times appeared
# Example below:
# 192.0.2.44 - - [28/May/2026:09:00:07 +0000] "POST /api/login HTTP/1.1" 401 91 "https://shop.example.com/login" "Mozilla/5.0" 0.020

set -euo pipefail
DEBUG="${DEBUG:-false}"

debug() {
  if [[ "$DEBUG" == "true" ]]; then
    echo "[DEBUG] $*" >&2
    fi
}

# Want to get the Directory script is running from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
debug "SCRIPT_DIR=$SCRIPT_DIR"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
debug "REPO_ROOT=$REPO_ROOT"

LOG_FILE="${1:-$REPO_ROOT/sample-data/nginx/sample_access.log}"


awk '$9 ~ /^4/ {print $1}' $LOG_FILE | sort | uniq -c | sort -nr | awk '{print$2, $1}'


