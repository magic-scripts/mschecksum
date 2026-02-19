#!/bin/sh

# mschecksum - Magic Scripts command

VERSION="0.1.0"
SCRIPT_NAME="mschecksum"

show_help() {
    echo "$SCRIPT_NAME v$VERSION"
    echo "SHA256 checksum calculator for Magic Scripts packages"
    echo ""
    echo "Usage:"
    echo "  $SCRIPT_NAME              Run the command"
    echo "  $SCRIPT_NAME --help       Show this help message"
    echo "  $SCRIPT_NAME --version    Show version information"
}

show_version() {
    echo "$SCRIPT_NAME v$VERSION"
}

case "$1" in
    -h|--help|help)
        show_help
        exit 0
        ;;
    -v|--version|version)
        show_version
        exit 0
        ;;
esac

echo "Hello from mschecksum!"
