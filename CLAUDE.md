# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed with [chezmoi](https://www.chezmoi.io/), a dotfile management tool that uses templating to handle cross-platform configurations. The repository follows chezmoi's conventions where source files are stored in the `home/` directory and deployed to the user's home directory.

## Key Commands

### Chezmoi Operations
```bash
# Apply dotfiles changes to the system
chezmoi apply

# Edit a managed file (opens in editor)
chezmoi edit ~/.config/fish/config.fish

# Add changes back to the repository
chezmoi add ~/.config/fish/config.fish

# View all managed files
chezmoi managed

# View the computed data/variables
chezmoi data

# Test template rendering without applying
chezmoi execute-template < template_file.tmpl
```

### Development Workflow
```bash
# After making changes to templates
chezmoi diff  # Preview changes
chezmoi apply # Apply changes to system

# Commit changes
cd $(chezmoi source-path)
git add .
git commit -m "message"
git push
```

## Architecture & Structure

### Chezmoi Naming Conventions
Files in `home/` use special prefixes that chezmoi interprets:
- `dot_` becomes `.` (e.g., `dot_zprofile` → `.zprofile`)
- `private_` sets file permissions to 0600
- `empty_` creates an empty file if it doesn't exist
- `.tmpl` suffix indicates a template file that will be processed

### Template System
Templates use Go's text/template syntax with access to:
- `.chezmoi.os` - Operating system (darwin, linux, windows)
- `.chezmoi.arch` - Architecture (amd64, arm64, etc.)
- `.chezmoi.hostname` - Machine hostname
- `.chezmoi.username` - Current username
- Custom data from `.chezmoidata/` files (if present)

Example template patterns:
```
{{ if eq .chezmoi.os "darwin" -}}
# macOS specific configuration
{{ else if eq .chezmoi.os "linux" -}}
# Linux specific configuration
{{ end -}}
```

### Configuration Components

**Shell Configuration:**
- Fish shell (`home/private_dot_config/private_fish/`) - Primary shell with modular conf.d setup
- PowerShell (`home/private_dot_config/powershell/`) - Cross-platform PowerShell profiles
- Zsh (`.zprofile`) - Basic profile for compatibility

**Development Tools:**
- Git configuration with SSH signing via 1Password
- mise for tool version management (replaces asdf/nvm/rbenv)
- Starship prompt with consistent theming
- VS Code and Ghostty terminal configurations

**Package Management:**
- Brewfile.tmpl - Homebrew packages for macOS
- mise configuration for language runtimes (Go, Node, Rust)

### Important Notes

1. **All edits should be made to files in the `home/` directory**, not to the deployed files in the user's home directory
2. **Template files (.tmpl) must have valid Go template syntax** - syntax errors will prevent chezmoi from applying changes
3. **The `.chezmoiroot` file sets `home` as the source root**, so all managed files are under `home/`
4. **Git signing is configured to use 1Password's SSH agent** - ensure 1Password CLI is installed and configured
5. **Cross-platform compatibility is handled through templates** - always consider platform differences when editing