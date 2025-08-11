# mschecksum - Checksum Calculator

Simple SHA256 checksum calculator designed for Magic Scripts ecosystem with standardized 8-character format.

## ✨ Features

- 🔐 **SHA256 Checksums**: Industry-standard cryptographic hashing
- 📏 **Magic Scripts Format**: First 8 characters of hex digest (standard format)
- ⚡ **Cross-Platform**: Works on Linux, macOS, and other Unix systems
- 🛠️ **Multiple Tools**: Auto-detects available tools (sha256sum, shasum, openssl)

## 🚀 Installation

### Via Magic Scripts (Recommended)

```bash
# Install Magic Scripts system
curl -fsSL https://raw.githubusercontent.com/magic-scripts/ms/main/setup.sh | sh

# Install mschecksum
ms install mschecksum
```

### Manual Installation

```bash
# Download and make executable
curl -fsSL https://raw.githubusercontent.com/magic-scripts/mschecksum/main/scripts/mschecksum.sh -o ~/.local/bin/mschecksum
chmod +x ~/.local/bin/mschecksum
```

## 📖 Usage

### Quick Start

```bash
# Calculate checksum for a file
mschecksum ./scripts/my-script.sh

# Output:
# File: ./scripts/my-script.sh
# SHA256 (first 8 chars): a1b2c3d4
```

### Examples

```bash
# Basic file checksum
mschecksum important-file.txt

# Check version
mschecksum --version

# Show help
mschecksum --help

# Use in script automation
for file in scripts/*.sh; do
    mschecksum "$file"
done
```

### Options

| Option | Description | Default |
|--------|-------------|---------|
| `-h, --help` | Show help message | - |
| `-v, --version` | Show version information | - |
| `file_path` | Path to file for checksum calculation | Required |

## ⚙️ Configuration

mschecksum uses the Magic Scripts configuration system:

```bash
# View configuration
ms config list | grep mschecksum

# Set preferred checksum tool (optional)
ms config set CHECKSUM_TOOL sha256sum

# Enable verbose output
ms config set CHECKSUM_VERBOSE true
```

### Available Configuration Keys

| Key | Description | Default | Category |
|-----|-------------|---------|----------|
| `CHECKSUM_TOOL` | Preferred tool (sha256sum, shasum, openssl) | `auto-detect` | tool |
| `CHECKSUM_VERBOSE` | Show detailed output | `false` | output |
| `CHECKSUM_FORMAT` | Output format preference | `magic-scripts` | format |

## 📚 Examples & Use Cases

### Magic Scripts Development

Perfect for calculating checksums when creating or updating `.msver` files:

```bash
# Calculate checksum for your script
mschecksum ./my-script.sh
# File: ./my-script.sh
# SHA256 (first 8 chars): a1b2c3d4

# Add to .msver file:
# version|1.0.0|https://example.com/my-script.sh|a1b2c3d4
```

### File Integrity Verification

Quickly verify file integrity during development:

```bash
# Initial checksum
mschecksum important-config.json
# SHA256 (first 8 chars): d5e6f7g8

# After modifications, verify changes
mschecksum important-config.json
# SHA256 (first 8 chars): f9a0b1c2  # Changed = file modified
```

### Batch Processing

Use in scripts for automated checksum calculation:

```bash
#!/bin/bash
echo "Calculating checksums for all scripts..."
for file in scripts/*.sh; do
    echo "Processing $file..."
    mschecksum "$file"
    echo ""
done
```

## 🔧 Integration

### With Other Tools

mschecksum works well with:
- **Magic Scripts Registry**: Standard checksum format for .msver files
- **Version Control**: Track file changes with checksum comparison
- **CI/CD Pipelines**: Automated integrity verification

### Workflow Examples

```bash
# Script deployment verification
mschecksum deploy-script.sh > checksum.txt
scp deploy-script.sh server:/opt/scripts/
ssh server "cd /opt/scripts && mschecksum deploy-script.sh"
# Compare checksums to verify transfer integrity
```

## 🛠️ Development

### Building from Source

```bash
git clone https://github.com/magic-scripts/mschecksum.git
cd mschecksum
# No build required - it's a shell script
```

### Testing

```bash
# Test with sample files
echo "hello world" > test.txt
mschecksum test.txt
# Expected: SHA256 (first 8 chars): 2c26b46b

# Test error handling
mschecksum nonexistent.txt
# Expected: Error: File 'nonexistent.txt' not found
```

### Supported Tools

- **sha256sum**: Linux standard (preferred)
- **shasum**: macOS standard with `-a 256`
- **openssl**: Fallback option with `dgst -sha256`

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🔗 Related Projects

- **[magic-scripts/ms](https://github.com/magic-scripts/ms)** - Magic Scripts core system
- **[magic-scripts/projinit](https://github.com/magic-scripts/projinit)** - Project initializer
- **[magic-scripts/dockergen](https://github.com/magic-scripts/dockergen)** - Dockerfile generator

---

Part of the [Magic Scripts](https://github.com/magic-scripts/ms) ecosystem.