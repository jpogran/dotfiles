# Universal utility functions for fish

function update_everything --description "Update all package managers and tools"
    echo "🔄 Updating system packages and tools..."

    # Homebrew
    if type -q brew
        echo "🍺 Updating Homebrew packages..."
        brew update
        brew upgrade
        brew cleanup
    end

    # mise (previously rtx)
    if type -q mise
        echo "📦 Updating mise tools..."
        mise upgrade
    end

    # Chezmoi
    if type -q chezmoi
        echo "🏠 Updating dotfiles..."
        chezmoi update
    end

    # Mac App Store (if on macOS)
    if type -q mas
        echo "🍎 Updating Mac App Store apps..."
        mas upgrade
    end

    # Fish plugins
    if set -q fisher_path
        echo "🐟 Updating fish plugins..."
        fisher update
    end

    echo "✅ All updates complete!"
end

function mkcd --description "Create and change to a directory"
    command mkdir -p $argv
    if test $status = 0
        cd $argv
    end
end

# Check for security updates daily
function check_for_updates --description "Check for important system updates"
    set last_check_file $XDG_CACHE_HOME/last_update_check

    # Default to 7 days ago if no file exists
    if not test -f $last_check_file
        touch -d "7 days ago" $last_check_file
    end

    # Check if file is older than 24 hours
    if test (find $last_check_file -mtime +1)
        echo "🔍 Checking for important updates..."

        # Update timestamp
        touch $last_check_file

        # On macOS
        if test (uname) = Darwin
            # Check for security updates on macOS
            softwareupdate --list | grep -i security >/dev/null
            if test $status -eq 0
                echo "⚠️ Security updates are available. Run 'softwareupdate --install --all' to install them."
            end
        end
    end
end
