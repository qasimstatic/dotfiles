# Dependencies: starship, vivid, zoxide, atuin

# =============================================================================
# Environment & Theme
# =============================================================================

source env.nu
source catppuccin/themes/catppuccin_mocha.nu
source tools/starship.nu

# Prompt Configuration
$env.PROMPT_INDICATOR         = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "› " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Color Scheme
# Cached from: vivid generate catppuccin-mocha
# Regenerate with: vivid generate catppuccin-mocha | save -f ~/.config/nushell/catppuccin/ls_colors.txt
$env.LS_COLORS = (open ~/.config/nushell/catppuccin/ls_colors.txt | str trim)

# =============================================================================
# Helper Functions
# =============================================================================

# Set terminal window title
def set-title [text: string] {
    print -n $"(char --integer 0x1b)]2;($text)(char --integer 0x07)"
}

# =============================================================================
# Core Configuration
# =============================================================================

$env.config = {
    # Display
    show_banner: false
    edit_mode: 'vi'

    # Shell Integration
    shell_integration: {
        osc2: false
        reset_application_mode: true
    }

    # Listing
    ls: {
        use_ls_colors: true
        clickable_links: true
    }

    # Tables
    table: {
        mode: heavy
        index_mode: always
        show_empty: true
    }

    # History
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
    }

    # Completions
    completions: {
        algorithm: "fuzzy"
        case_sensitive: false
        quick: true
        sort: "smart"
        external: {
            enable: true
            max_results: 50
        }
    }

    # Hooks
    hooks: {
        pre_prompt: [
            { || set-title "nu" }
        ]
        pre_execution: [
            { ||
                let cmd = (commandline | str trim)
                let exe = ($cmd | split row ' ' | get 0?)
                if ($exe | is-not-empty) and ($exe != "") {
                    set-title $exe
                }
            }
        ]
    }
}

# =============================================================================
# Tool Integrations
# =============================================================================
# Note: atuin.nu must be sourced after $env.config is defined

source tools/atuin.nu
source tools/zoxide.nu
source tools/journal.nu
source tools/pomodoro.nu
source tools/dots.nu

# =============================================================================
# Custom Commands
# =============================================================================

# Edit files with neovim
def n [...args: string] {
    if ($args | is-empty) { ^nvim . } else { ^nvim ...$args }
}

# Launch gitui with SSH key check
def gt [] {
    let result = (ssh-add -l | complete)
    if $result.exit_code != 0 {
        ssh-add ~/.ssh/id_ed25519
    }
    gitui
}

# =============================================================================
# Aliases
# =============================================================================

# ----- Navigation -----
alias ..  = cd ..
alias ... = cd ../..
alias .... = cd ../../..

# ----- General -----
alias lsa = ls -a
alias cls = clear
alias vim = nvim
alias hx  = helix
alias about = fastfetch
alias thestandup = cliamp https://rss2.flightcast.com/pmgqiszts7kfhopzaq8el6yw.xml

# ----- Tools -----
alias ts   = tmux-sessionizer
alias oc   = opencode
alias co   = copilot
alias todo = taskwarrior-tui
alias sync-dots = bash -c "find ~/.config -type f \\( -name '*.lua' -o -name '*.conf' -o -name '*.json' -o -name '*.ron' -o -name '*.toml' -o -name '*.ini' \\) -exec chmod -x {} \\; && chezmoi add ~/.config/{hypr,nvim,waybar,ghostty,nushell,fuzzel,rmpc,systemd} ~/.config/starship.toml && cd ~/.local/share/chezmoi && git add -A && git commit -m 'sync: update dotfiles' && git push"

# ----- Git -----
alias g    = git
alias gcm  = git commit -m
alias gcam = git commit -a -m
alias gcad = git commit -a --amend

# ----- Optional Tools -----
alias d   = docker
alias r   = rails

# =============================================================================
# Development Tools
# =============================================================================

# ----- Rust -----
alias c  = cargo
alias cb = cargo build
alias cr = cargo run
alias ct = cargo test
alias cc = cargo clippy
alias cf = cargo fmt
alias rs = rustc

# ----- Build Systems -----
alias mk = make
alias cm = cmake
alias ms = meson
alias nn = ninja

# ----- Compilers -----
alias gpp = g++
alias cl  = clang
alias clp = clang++

# ----- Debuggers -----
alias gd = gdb
alias ld = lldb

# ----- Rust C Binding Tools -----
alias bg  = bindgen
alias cbg = cbindgen

# =============================================================================
# Debug (uncomment to enable)
# =============================================================================
print $"(ansi { fg: teal, attr: b })startup time:(ansi reset) (nu -n --no-std-lib -c 'print $nu.startup-time')"
