# Pomodoro Timer for Nushell
# Based on: https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7
# Uses timer command and notify-send for notifications

# Timer durations in minutes
const DURATIONS = {
    work: 30,
    break: 5,
    long_break: 15
}

# Start a pomodoro timer
def start-pomodoro [
    session_type: string  # work, break, or long_break
] {
    # Validate session type
    if $session_type not-in ($DURATIONS | columns) {
        print -e $"(ansi red_bold)Invalid session type: ($session_type)(ansi reset)"
        print -e $"(ansi yellow)Valid options: ($DURATIONS | columns | str join ', ')(ansi reset)"
        return
    }

    let duration = $DURATIONS | get $session_type

    # Display start message
    print $"(ansi green_bold)Starting ($session_type) session for ($duration) minutes(ansi reset)"
    print "Press Ctrl+C to interrupt"

    try {
        # Run timer command
        do { ^/usr/bin/timer $"($duration)m" }

        # Timer completed
        let completion_message = match $session_type {
            "work" => "Work session completed! Time for a break."
            "break" => "Break completed! Ready to work again."
            "long_break" => "Long break completed! Ready to work again."
        }

        print ""
        print $"(ansi green_bold)($completion_message)(ansi reset)"

        # Send system notification
        ^notify-send $"Pomodoro Timer" $"($session_type | str upcase) session completed" -u normal

    } catch {
        # Timer interrupted
        print ""
        print $"(ansi yellow)Timer interrupted(ansi reset)"

        # Send notification about interruption
        ^notify-send $"Pomodoro Timer" $"($session_type | str upcase) session interrupted" -u low
    }
}


# Alias: Start work session (25 minutes)
def "wo" [] {
    start-pomodoro "work"
}

# Alias: Start break session (5 minutes)
def "br" [] {
    start-pomodoro "break"
}

# Alias: Start long break session (15 minutes)
def "lb" [] {
    start-pomodoro "long_break"
}

# Display help information
def "pomo-help" [] {
    print $"(ansi blue_bold)Pomodoro Timer Commands:(ansi reset)"
    print ""
    print "  wo        - Start work session - 30 minutes"
    print "  br        - Start break session - 5 minutes"
    print "  lb        - Start long break session - 15 minutes"
    print "  pomo-help - Show this help message"
    print ""
    print "  Uses the system timer command and sends desktop notifications."
    print "  Press Ctrl+C to interrupt an active timer."
}
