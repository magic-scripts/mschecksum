#!/bin/bash

MANPAGE="/usr/local/share/man/man1/mschecksum.1"
if [[ -f "$MANPAGE" ]]; then
    echo "Removing man page for mschecksum..."
    sudo rm -f "$MANPAGE"
    sudo mandb -q 2>/dev/null || true
    echo "Man page removed successfully"
fi

echo "mschecksum uninstall script completed successfully"