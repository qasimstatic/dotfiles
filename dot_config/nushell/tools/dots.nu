# Dotfiles sync tool for chezmoi

# Sync dotfiles to chezmoi source directory
export def dots-sync [] {
    # Fix permissions using bash
    bash -c 'find ~/.config -type f \( -name "*.lua" -o -name "*.conf" -o -name "*.json" -o -name "*.jsonc" -o -name "*.ron" -o -name "*.toml" -o -name "*.ini" -o -name "*.css" -o -name "*.nu" -o -name "*.scm" \) -exec chmod -x {} + 2>/dev/null'
    
    print "Syncing configs to chezmoi..."
    
    chezmoi add ~/.config/hypr
    chezmoi add ~/.config/nvim
    chezmoi add ~/.config/waybar
    chezmoi add ~/.config/ghostty
    chezmoi add ~/.config/nushell
    chezmoi add ~/.config/fuzzel
    chezmoi add ~/.config/rmpc
    chezmoi add ~/.config/starship.toml
    chezmoi add ~/.config/systemd
    
    print "Done."
}

# Show git status in chezmoi directory
export def dots-status [] {
    cd ~/.local/share/chezmoi
    git status --short
}

# Sync and commit all changes with date
export def dots-commit [] {
    dots-sync
    
    cd ~/.local/share/chezmoi
    git add -A
    
    let date = (date now | format date "%d/%m/%y")
    git commit -m $"sync ($date)"
    
    print $"Committed: sync ($date)"
}

# Sync, commit, and push
export def dots-push [] {
    dots-commit
    cd ~/.local/share/chezmoi
    git push
    print "Pushed."
}

# Open chezmoi source directory
export def dots-cd [] {
    cd ~/.local/share/chezmoi
}

# Edit a config in chezmoi source
export def dots-edit [file: string] {
    chezmoi edit $file
}

# Apply chezmoi changes to system
export def dots-apply [] {
    chezmoi apply
    print "Applied."
}

# Stage specific files for commit
export def dots-stage [...files: string] {
    cd ~/.local/share/chezmoi
    git add ...$files
    print $"Staged: ($files | str join ' ')"
}

# Commit staged changes
export def "dots-commit-partial" [message: string] {
    cd ~/.local/share/chezmoi
    git commit -m $message
    print $"Committed: ($message)"
}
