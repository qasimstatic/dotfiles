#!/usr/bin/env nu

print "Setting up systemd services..."

# 1. Daemon reload first to pick up any new units created by chezmoi
print "Reloading systemd user daemon..."
systemctl --user daemon-reload

# 2. Extract and enable services based on .wants directories
let systemd_dir = ($env.HOME | path join ".config/systemd/user")

if ($systemd_dir | path exists) {
    # Find all symlinks inside any .wants directory
    let services_to_enable = (
        glob $"($systemd_dir)/**/*.wants/*"
        | path basename
        | str replace "symlink_" ""
        | uniq
    )

    for svc in $services_to_enable {
        print $"Enabling ($svc)..."
        try { 
            systemctl --user enable $svc 
        } catch {
            print $"[WARNING] Failed to enable ($svc)"
        }
    }
    
    try { systemctl --user enable --now pass-secret-service.service }
}

print "Systemd setup complete."
