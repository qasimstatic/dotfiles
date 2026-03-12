# This file works as:
#   - overlay: `overlay use starship.nu`
#   - module: `use starship.nu`
#   - script: `source starship.nu`

export-env {
    $env.STARSHIP_SHELL = "nu"
    $env.PROMPT_MULTILINE_INDICATOR = (^/usr/bin/starship prompt --continuation)
    $env.PROMPT_INDICATOR = ""

    $env.PROMPT_COMMAND = {||
        let cmd_duration = if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS }
        let jobs_arg = if (which "job list" | where type == built-in | is-not-empty) {
            ["--jobs", $"{(job list | length)}"]
        } else { [] }
        ^/usr/bin/starship prompt --cmd-duration $cmd_duration --status $env.LAST_EXIT_CODE --terminal-width (term size).columns ...$jobs_arg
    }

    $env.config = ($env.config? | default {} | merge { render_right_prompt_on_last_line: true })

    $env.PROMPT_COMMAND_RIGHT = {||
        let cmd_duration = if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS }
        let jobs_arg = if (which "job list" | where type == built-in | is-not-empty) {
            ["--jobs", $"{(job list | length)}"]
        } else { [] }
        ^/usr/bin/starship prompt --right --cmd-duration $cmd_duration --status $env.LAST_EXIT_CODE --terminal-width (term size).columns ...$jobs_arg
    }

    $env.STARSHIP_SESSION_KEY = (random chars -l 16)
}
