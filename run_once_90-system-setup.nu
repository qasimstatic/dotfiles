#!/usr/bin/env nu

print "Setting up system-level configurations..."
print "This script requires sudo to configure SDDM, bootloader, and TTY."

let dotfiles_dir = ($env.HOME | path join ".local/share/chezmoi")

# Define copies as a list of records
let ops = [
    { src: "boot/loader/loader.conf", dest: "/boot/loader/loader.conf", type: "file" },
    { src: "boot/loader/entries/arch.conf", dest: "/boot/loader/entries/arch.conf", type: "file" },
    { src: "etc/vconsole.conf", dest: "/etc/vconsole.conf", type: "file" },
    { src: "etc/sddm.conf.d", dest: "/etc/sddm.conf.d", type: "dir" },
]

for op in $ops {
    let full_src = ($dotfiles_dir | path join $op.src)
    
    if ($full_src | path exists) {
        if ($op.type == "dir") {
            sudo mkdir -p $op.dest
            sudo cp -r $"($full_src)/*" $op.dest
        } else {
            let parent_dest = ($op.dest | path dirname)
            sudo mkdir -p $parent_dest
            sudo cp $full_src $op.dest
        }
        print $"Copied ($op.src) to ($op.dest)"
    } else {
        print $"[WARNING] Source ($full_src) missing in dotfiles."
    }
}

print "Updating bootloader..."
try { 
    sudo bootctl update 
} catch {
    print "[WARNING] bootctl update failed."
}

print "System setup complete! Reboot to apply TTY theme and SDDM."
