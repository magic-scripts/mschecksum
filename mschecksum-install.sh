#!/bin/bash

MANDIR="/usr/local/share/man/man1"
if [[ ! -d "$MANDIR" ]]; then
    sudo mkdir -p "$MANDIR"
fi

echo "Installing man page for mschecksum..."
sudo tee "$MANDIR/mschecksum.1" > /dev/null << 'EOF'
.TH MSCHECKSUM 1 "$(date +'%B %Y')" "mschecksum 1.0.0" "User Commands"
.SH NAME
mschecksum \- SHA256 checksum calculator for Magic Scripts
.SH SYNOPSIS
.B mschecksum
[\fIOPTION\fR]...
.SH DESCRIPTION
mschecksum computes the first 8 characters of SHA256 hash for files,
formatted specifically for the Magic Scripts ecosystem.
.SH OPTIONS
.TP
.B \-h, \-\-help
Display help information and exit
.TP
.B \-v, \-\-version
Display version information and exit
.SH AUTHOR
Written by Magic Scripts Team
.SH SEE ALSO
.BR ms (1)
EOF

sudo mandb -q 2>/dev/null || true
echo "mschecksum install script completed successfully"