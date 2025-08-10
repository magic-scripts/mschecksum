#!/bin/sh

# Magic Scripts Checksum Calculator
# Simple SHA256 checksum calculator for Magic Scripts

VERSION="0.1.0"
SCRIPT_NAME="mschecksum"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

show_help() {
    echo "${CYAN}$SCRIPT_NAME v$VERSION${NC}"
    echo "Magic Scripts Checksum Calculator"
    echo ""
    echo "Usage:"
    echo "  ${CYAN}$SCRIPT_NAME <file_path>${NC}"
    echo "  ${CYAN}$SCRIPT_NAME --version, -v${NC}"
    echo "  ${CYAN}$SCRIPT_NAME --help, -h${NC}"
    echo ""
    echo "Description:"
    echo "  Calculates SHA256 checksum for files using the Magic Scripts format"
    echo "  (first 8 characters of SHA256 hex digest)"
    echo ""
    echo "Examples:"
    echo "  ${CYAN}$SCRIPT_NAME ./scripts/my-script.sh${NC}"
    echo "  ${CYAN}$SCRIPT_NAME ~/Downloads/script.sh${NC}"
    echo ""
    echo "Output format:"
    echo "  File: <file_path>"
    echo "  SHA256 (first 8 chars): <checksum>"
}

show_version() {
    echo "$SCRIPT_NAME v$VERSION"
}

# Calculate SHA256 checksum of a file (first 8 characters)
calculate_checksum() {
    local file_path="$1"
    
    if [ ! -f "$file_path" ]; then
        echo "${RED}Error: File '$file_path' not found${NC}" >&2
        return 1
    fi
    
    local checksum=""
    
    # Try different checksum tools in order of preference
    if command -v sha256sum >/dev/null 2>&1; then
        checksum=$(sha256sum "$file_path" | cut -d' ' -f1 | cut -c1-8)
    elif command -v shasum >/dev/null 2>&1; then
        checksum=$(shasum -a 256 "$file_path" | cut -d' ' -f1 | cut -c1-8)
    elif command -v openssl >/dev/null 2>&1; then
        checksum=$(openssl dgst -sha256 "$file_path" | cut -d' ' -f2 | cut -c1-8)
    else
        echo "${RED}Error: No SHA256 tool found (sha256sum, shasum, or openssl required)${NC}" >&2
        return 1
    fi
    
    if [ -z "$checksum" ]; then
        echo "${RED}Error: Failed to calculate checksum${NC}" >&2
        return 1
    fi
    
    # Output in Magic Scripts format
    echo "File: $file_path"
    echo "SHA256 (first 8 chars): ${GREEN}$checksum${NC}"
    
    return 0
}

# Main script logic
case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--version)
        show_version
        exit 0
        ;;
    "")
        echo "${RED}Error: Missing file path${NC}" >&2
        echo "Use ${CYAN}$SCRIPT_NAME --help${NC} for usage information" >&2
        exit 1
        ;;
    *)
        if [ $# -gt 1 ]; then
            echo "${RED}Error: Too many arguments${NC}" >&2
            echo "Use ${CYAN}$SCRIPT_NAME --help${NC} for usage information" >&2
            exit 1
        fi
        
        calculate_checksum "$1"
        exit $?
        ;;
esac