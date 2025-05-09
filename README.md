# github.com/jpogran/dotfiles 🚀

James Pogran's dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

## 📥 Installation

The simplest way to install these dotfiles:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jpogran
```

For more verbose output:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose https://github.com/jpogran/dotfiles.git
```

### Quick Start for New Machines

For a complete setup on a new machine, run the bootstrap script:

```bash
# On macOS or Linux
curl -fsSL https://raw.githubusercontent.com/jpogran/dotfiles/main/scripts/bootstrap-env.sh | bash

# On Windows (using PowerShell)
irm https://raw.githubusercontent.com/jpogran/dotfiles/main/bootstrap.ps1 | iex
```

## 🔍 What's Included

- **Shell**: Fish shell and PowerShell configurations with various utilities
- **Terminal**: iTerm2, Ghostty, and Windows Terminal configurations with cross-platform theme
- **Editor**: VS Code and Neovim settings with consistent theming
- **Git**: Comprehensive Git configuration with useful aliases and signing
- **Package Management**: Homebrew packages and mise tool version management
- **macOS**: Sensible macOS defaults and configurations
- **Cross-Platform**: Templates that adapt to different operating systems

## 🔄 Updating

To update your dotfiles after changes:

```bash
chezmoi update
```

If you've made changes to your local configuration that you want to push back to the repository:

```bash
# Update specific file
chezmoi edit ~/.zshrc
chezmoi add ~/.zshrc
chezmoi cd
git add .
git commit -m "Updated zshrc"
git push

# Or update all managed files at once
chezmoi re-add
```

## 📊 Data-Driven Configuration

This dotfiles setup uses a data-driven approach with YAML configuration files in `.chezmoidata/`:

- `info.yml` - Core user information, editor preferences, and theme settings
- `packages.yml` - Package management for different profiles (universal, work, personal)
- `schema.yml` - Documentation of the data structure (read this to understand the configuration)

To view the computed configuration:

```bash
chezmoi data
```

## 🎨 Themes and Customization

The configuration uses a central theme definition in `info.yml`:

```yaml
data:
  theme:
    name: "github_dark"
    colors:
      accent: "#F78166"
      surface: "#0d1117"
      text: "#c9d1d9"
```

These values are used consistently across:
- Terminal color schemes
- Prompt styling (Starship)
- Editor themes
- Git UI colors

## 🔧 Advanced Usage

### Platform-Specific Settings

Templates automatically adapt to your platform:

```
{{ if eq .chezmoi.os "darwin" -}}
# macOS specific settings
{{ else if eq .chezmoi.os "linux" -}}
# Linux specific settings
{{ else if eq .chezmoi.os "windows" -}}
# Windows specific settings
{{ end -}}
```

### Work vs. Personal Profile

Package installation adapts based on the `isWorkMachine` setting:

```bash
# Check current profile
chezmoi data | grep isWorkMachine

# Switch profile
chezmoi apply --force --data='{isWorkMachine: true}'
```

## 📝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
