# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

### Chezmoi Operations
- `chezmoi update` - Update dotfiles from the repository
- `chezmoi apply` - Apply current configuration to the system
- `chezmoi data` - View computed configuration data
- `chezmoi re-add` - Update all managed files from their current state
- `chezmoi edit <file>` - Edit a managed file
- `chezmoi add <file>` - Start managing a new file

### Development Workflow
```bash
# Make changes to config files
chezmoi edit ~/.config/git/config
chezmoi add ~/.config/git/config

# Commit changes
chezmoi cd
git add .
git commit -m "Description of changes"
git push

# Or update all managed files at once
chezmoi re-add
```

### Package Management
- `brew bundle --file=~/Brewfile` - Install all Homebrew packages
- `mise install` - Install all language runtimes defined in mise config
- `mise use <tool>@<version>` - Set tool version for current directory

## Architecture Overview

This is a **chezmoi-managed dotfiles repository** with the following key characteristics:

### Template-Driven Configuration
- Files use `.tmpl` extension for template processing
- Templates support conditional logic based on OS and machine type
- Configuration is data-driven using `.chezmoidata/info.yml`

### Directory Structure
```
home/                           # Files that map to home directory
├── .chezmoidata/
│   └── info.yml               # Core configuration data
├── Brewfile.tmpl              # Homebrew package definitions
├── private_dot_config/        # Maps to ~/.config/
│   ├── git/private_config.tmpl
│   ├── mise/config.toml.tmpl
│   ├── private_fish/          # Fish shell configuration
│   └── ghostty/config.tmpl
└── private_dot_ssh/           # SSH configuration
```

### Cross-Platform Support
Templates automatically adapt behavior based on:
- `{{ .chezmoi.os }}` - Operating system (darwin, linux, windows)
- `{{ .chezmoi.arch }}` - Architecture
- Custom data variables from `info.yml`

### Key Configuration Files
- `home/.chezmoidata/info.yml` - User information and preferences
- `home/Brewfile.tmpl` - macOS package management via Homebrew
- `home/private_dot_config/mise/config.toml.tmpl` - Language runtime management
- `home/private_dot_config/git/private_config.tmpl` - Git configuration with extensive aliases
- `home/private_dot_config/private_fish/` - Fish shell configuration with modular conf.d structure

### Security Considerations
- Files prefixed with `private_` are treated as sensitive by chezmoi
- SSH keys and configurations are properly secured
- Git signing is configured using 1Password SSH agent
- GPG signing enabled for commits

## Template Variables

Access user data in templates via:
- `{{ .editor }}` - Default editor (code --wait)
- `{{ .email }}` - User email
- `{{ .fullname }}` - Full name
- `{{ .username }}` - Primary username
- `{{ .work_username }}` - Work-specific username

## Development Tools Configuration

### Language Runtimes (mise)
- Go: latest version
- Node.js: LTS version
- Ruby: idiomatic version file support enabled

### Editor Integration
- VS Code configured as default editor with `--wait` flag
- Consistent across Git, shell, and system configurations

### Shell Environment
- Primary shell: Fish with modular configuration in `conf.d/`
- Prompt: Starship with theme integration
- Aliases and abbreviations defined in separate fish files