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

# SSH AUTH
if ($env.XDG_RUNTIME_DIR | path exists) {
    $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
}

# Bun
$env.BUN_INSTALL = $"($env.HOME)/.bun"
$env.PATH = ($env.PATH | prepend ($env.BUN_INSTALL | path join "bin"))

# Node.js module resolution for bun-installed packages
let bun_cache = ($env.BUN_INSTALL | path join "install" "cache")
let bun_global = ($env.BUN_INSTALL | path join "install" "global" "node_modules")
let node_paths = ([$bun_cache $bun_global] | where { |p| ($p | path exists) })
if not ($node_paths | is-empty) {
  let existing = ($env.NODE_PATH? | default "")
  if ($existing | str length) == 0 {
    $env.NODE_PATH = ($node_paths | str join ":")
  } else {
    $env.NODE_PATH = ($node_paths | append $existing | str join ":")
  }
}

# Opencode
$env.OPENCODE_ENABLE_EXA = "true"
