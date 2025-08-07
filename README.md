# mschecksum - Magic Scripts Checksum Calculator

Simple SHA256 checksum calculator designed for Magic Scripts ecosystem.

## Features

- 🔐 **SHA256 Checksums**: Industry-standard cryptographic hashing
- 📏 **Magic Scripts Format**: First 8 characters of hex digest (standard format)
- ⚡ **Cross-Platform**: Works on Linux, macOS, and other Unix systems
- 🛠️ **Multiple Tools**: Auto-detects available tools (sha256sum, shasum, openssl)
- 📄 **Clean Output**: Simple, parseable output format

## Installation

```bash
ms install mschecksum
```

## Usage

```bash
# Calculate checksum for a file
mschecksum ./scripts/my-script.sh

# Output:
# File: ./scripts/my-script.sh
# SHA256 (first 8 chars): a1b2c3d4

# Check version
mschecksum --version

# Show help
mschecksum --help
```

## Use Cases

### Magic Scripts Development
Perfect for calculating checksums when creating or updating `.msver` files:

```bash
# Calculate checksum for your script
mschecksum ./my-script.sh

# Add to .msver file:
version|1.0.0|https://example.com/my-script.sh|a1b2c3d4
```

### File Integrity Verification
Quickly verify file integrity during development:

```bash
# Check if file changed
mschecksum important-file.txt
# SHA256 (first 8 chars): d5e6f7g8

# Later...
mschecksum important-file.txt  
# SHA256 (first 8 chars): d5e6f7g8  # Same = no changes
```

### Batch Processing
Use in scripts for automated checksum calculation:

```bash
#!/bin/sh
for file in scripts/*.sh; do
    echo "Processing $file..."
    mschecksum "$file"
    echo ""
done
```

## Supported Tools

mschecksum automatically detects and uses available tools:

1. **sha256sum** - Linux standard (preferred)
2. **shasum** - macOS standard with `-a 256` 
3. **openssl** - Fallback option with `dgst -sha256`

## Output Format

```
File: <file_path>
SHA256 (first 8 chars): <checksum>
```

The 8-character format is the Magic Scripts standard for compact checksums while maintaining reasonable collision resistance.

## Error Handling

- ❌ **File not found**: Clear error message
- ❌ **No checksum tool**: Lists required tools
- ❌ **Calculation failed**: Reports failure with context
- ❌ **Invalid arguments**: Shows usage help

## Examples

```bash
# Basic usage
$ mschecksum hello.sh
File: hello.sh
SHA256 (first 8 chars): 2c26b46b

# File not found
$ mschecksum missing.sh
Error: File 'missing.sh' not found

# Multiple arguments (error)
$ mschecksum file1.sh file2.sh
Error: Too many arguments
Use mschecksum --help for usage information
```

## Why 8 Characters?

The 8-character checksum provides:
- **Reasonable collision resistance**: ~4 billion possibilities
- **Compact representation**: Fits well in registry files
- **Human readable**: Easy to compare and verify
- **Industry practice**: Common in package managers and version control

For critical security applications, use the full SHA256 hash from the underlying tools.

## Version

Dev version - latest features from develop branch.

## License

MIT License