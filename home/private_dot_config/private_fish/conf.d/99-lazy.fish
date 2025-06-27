#!/usr/bin/env fish

# Lazy load heavy completions to improve shell startup time
function __load_completions --on-event fish_prompt
    if not set -q __completions_loaded
        # Load completions for tools that are slow to initialize
        if command -v gh >/dev/null
            gh completion -s fish | source 2>/dev/null
        end

        set -g __completions_loaded true
        functions -e __load_completions
    end
end
