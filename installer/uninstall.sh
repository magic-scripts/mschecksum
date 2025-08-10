#!/bin/bash

# Magic Scripts Uninstall Script for mschecksum
# Removes man page

mschecksum="mschecksum"
MANPAGE="/usr/local/share/man/man1/${mschecksum}.1"

if [[ -f "$MANPAGE" ]]; then
    echo "Removing man page for $mschecksum..."
    sudo rm -f "$MANPAGE"
    sudo mandb -q 2>/dev/null || true
    echo "Man page removed successfully"
else
    echo "No man page found for $mschecksum"
fi