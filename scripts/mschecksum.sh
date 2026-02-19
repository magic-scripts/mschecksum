#!/bin/sh
# mschecksum - SHA256 checksum calculator for Magic Scripts packages
#
# Calculates the first 8 characters of SHA256 hex digest,
# which is the standard checksum format used in Magic Scripts .msver files.

VERSION="0.1.0"
SCRIPT_NAME="mschecksum"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

show_help() {
    printf "%b\n" "${CYAN}${SCRIPT_NAME} v${MS_INSTALLED_VERSION:-$VERSION}${NC}"
    printf "SHA256 checksum calculator for Magic Scripts packages\n\n"
    printf "Usage:\n"
    printf "  %b\n" "${CYAN}${SCRIPT_NAME} <file_path>${NC}"
    printf "  %b\n" "${CYAN}${SCRIPT_NAME} --version, -v${NC}"
    printf "  %b\n\n" "${CYAN}${SCRIPT_NAME} --help, -h${NC}"
    printf "Description:\n"
    printf "  Calculates SHA256 checksum for files using the Magic Scripts format\n"
    printf "  (first 8 characters of SHA256 hex digest)\n\n"
    printf "Examples:\n"
    printf "  %b\n" "${CYAN}${SCRIPT_NAME} ./scripts/my-script.sh${NC}"
    printf "  %b\n\n" "${CYAN}${SCRIPT_NAME} ~/Downloads/script.sh${NC}"
    printf "Output format:\n"
    printf "  File: <file_path>\n"
    printf "  SHA256 (first 8 chars): <checksum>\n"
}

show_version() {
    printf "%s v%s\n" "$SCRIPT_NAME" "${MS_INSTALLED_VERSION:-$VERSION}"
}

# Calculate SHA256 checksum of a file (first 8 characters)
calculate_checksum() {
    local file_path="$1"

    if [ ! -f "$file_path" ]; then
        printf "%bError: File '%s' not found%b\n" "${RED}" "$file_path" "${NC}" >&2
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
        printf "%bError: No SHA256 tool found (sha256sum, shasum, or openssl required)%b\n" "${RED}" "${NC}" >&2
        return 1
    fi

    if [ -z "$checksum" ]; then
        printf "%bError: Failed to calculate checksum%b\n" "${RED}" "${NC}" >&2
        return 1
    fi

    printf "File: %s\n" "$file_path"
    printf "SHA256 (first 8 chars): %b%s%b\n" "${GREEN}" "$checksum" "${NC}"
}

# Main
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
        printf "%bError: Missing file path%b\n" "${RED}" "${NC}" >&2
        printf "Use %b%s --help%b for usage information\n" "${CYAN}" "$SCRIPT_NAME" "${NC}" >&2
        exit 1
        ;;
    *)
        if [ $# -gt 1 ]; then
            printf "%bError: Too many arguments%b\n" "${RED}" "${NC}" >&2
            printf "Use %b%s --help%b for usage information\n" "${CYAN}" "$SCRIPT_NAME" "${NC}" >&2
            exit 1
        fi
        calculate_checksum "$1"
        exit $?
        ;;
esac
