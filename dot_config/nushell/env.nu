# =============================================================================
# Environment Variables
# =============================================================================

# Editors
$env.EDITOR = "nvim"
$env.VISUAL  = "nvim"

# Pagers
$env.BAT_THEME = "ansi"
$env.MANPAGER  = "bat"
$env.PAGER     = "bat -p"

# Path additions
let local_bin = ("~/.local/bin" | path expand)
if ($local_bin | path exists) {
  $env.PATH = ($env.PATH | prepend $local_bin)
}

# Add Cargo binaries
let cargo_bin = ("~/.cargo/bin" | path expand)
if ($cargo_bin | path exists) {
  $env.PATH = ($env.PATH | prepend $cargo_bin)
}

# Add Go binaries
let go_path = ("~/go/bin" | path expand)
if ($go_path | path exists) {
  $env.PATH = ($env.PATH | prepend $go_path)
}

# UI tweaks
$env.GTK_ENABLE_ANIMATIONS = "0"
$env.QT_QPA_PLATFORMTHEME   = "gtk2"

# BAO Vault
# $env.BAO_ADDR = "http://127.0.0.1:8200"

# SSH AUTH
if ($env.XDG_RUNTIME_DIR | path exists) {
    $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
}

# Bun
$env.BUN_INSTALL = $"($env.HOME)/.bun"
$env.PATH = ($env.PATH | prepend ($env.BUN_INSTALL | path join "bin"))

# Jina
$env.JINA_API_KEY = "jina_6959aa3246834096822099c35aa8d6c4RnWeNjDUsVunsUJ3R6qL0eFyvvkR"

# Opencode
$env.OPENCODE_ENABLE_EXA = true
