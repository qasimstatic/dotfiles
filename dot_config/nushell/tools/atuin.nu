# Source this in your ~/.config/nushell/config.nu
# minimum supported version = 0.93.0
module compat {
  export def --wrapped "random uuid -v 7" [...rest] { atuin uuid }
}
use (if not (
    (version).major > 0 or
    (version).minor >= 103
) { "compat" }) *

$env.ATUIN_SESSION = (random uuid -v 7 | str replace -a "-" "")
hide-env -i ATUIN_HISTORY_ID

# Magic token to make sure we don't record commands run by keybindings
let ATUIN_KEYBINDING_TOKEN = $"# (random uuid)"

let _atuin_pre_execution = {||
    if ($nu | get history-enabled?) == false {
        return
    }
    let cmd = (commandline)
    if ($cmd | is-empty) {
        return
    }
    if not ($cmd | str starts-with $ATUIN_KEYBINDING_TOKEN) {
        $env.ATUIN_HISTORY_ID = (atuin history start -- $cmd)
    }
}

let _atuin_pre_prompt = {||
    let last_exit = $env.LAST_EXIT_CODE
    if 'ATUIN_HISTORY_ID' not-in $env {
        return
    }
    with-env { ATUIN_LOG: error } {
        if (version).minor >= 104 or (version).major > 0 {
            job spawn -t atuin {
                ^atuin history end $'--exit=($env.LAST_EXIT_CODE)' -- $env.ATUIN_HISTORY_ID | complete
            } | ignore
        } else {
            do { atuin history end $'--exit=($last_exit)' -- $env.ATUIN_HISTORY_ID } | complete
        }

    }
    hide-env ATUIN_HISTORY_ID
}

def _atuin_search_cmd [...flags: string] {
    if (version).minor >= 106 or (version).major > 0 {
        [
            $ATUIN_KEYBINDING_TOKEN,
            ([
                `with-env { ATUIN_LOG: error, ATUIN_QUERY: (commandline), ATUIN_SHELL: nu } {`,
                    ([
                        'let output = (run-external atuin search',
                        ($flags | append [--interactive] | each {|e| $'"($e)"'}),
                        'e>| str trim)',
                    ] | flatten | str join ' '),
                    'if ($output | str starts-with "__atuin_accept__:") {',
                    'commandline edit --accept ($output | str replace "__atuin_accept__:" "")',
                    '} else {',
                    'commandline edit $output',
                    '}',
                `}`,
            ] | flatten | str join "\n"),
        ]
    } else {
        [
            $ATUIN_KEYBINDING_TOKEN,
            ([
                `with-env { ATUIN_LOG: error, ATUIN_QUERY: (commandline) } {`,
                    'commandline edit',
                    '(run-external atuin search',
                        ($flags | append [--interactive] | each {|e| $'"($e)"'}),
                    ' e>| str trim)',
                `}`,
            ] | flatten | str join ' '),
        ]
    } | str join "\n"
}

# Set hooks properly - avoiding nested upsert issue
$env.config = ($env | default {} config).config

# Get existing hooks or default to empty
let existing_hooks = $env.config.hooks? | default {}

# Calculate new hook lists first
let new_pre_execution = ($existing_hooks.pre_execution? | default []) | append $_atuin_pre_execution
let new_pre_prompt = ($existing_hooks.pre_prompt? | default []) | append $_atuin_pre_prompt

# Merge hooks with new values
$env.config = $env.config | upsert hooks {
    pre_execution: $new_pre_execution,
    pre_prompt: $new_pre_prompt,
    env_change: $existing_hooks.env_change?,
    display_output: $existing_hooks.display_output?,
    command_not_found: $existing_hooks.command_not_found?,
}

$env.config = ($env.config | default [] keybindings)

$env.config = (
    $env.config | upsert keybindings (
        $env.config.keybindings
        | append {
            name: atuin
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: executehostcommand cmd: (_atuin_search_cmd) }
        }
    )
)

$env.config = (
    $env.config | upsert keybindings (
        $env.config.keybindings
        | append {
            name: atuin
            modifier: none
            keycode: up
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    {send: menuup}
                    {send: executehostcommand cmd: (_atuin_search_cmd '--shell-up-key-binding') }
                ]
            }
        }
    )
)
