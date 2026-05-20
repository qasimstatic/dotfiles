# Interactive Paru Installer

export def paru-install [] {
    try {
        paru -Qa | fzf --preview='paru -Qi {1}' --bind 'enter:execute(paru -S {1})+abort'
    } catch {
        print $"\n(ansi red)✗ Installation failed.(ansi reset)"
        print $"\n(ansi yellow)Please check the errors above and try again.(ansi reset)"
        return
    }

    if $env.LAST_EXIT_CODE == 0 {
        print $"\n(ansi green)✓ Installation successful!(ansi reset)"
    } else {
        print $"\n(ansi red)✗ Installation failed.(ansi reset)"
        print $"\n(ansi yellow)Please check the errors above and try again.(ansi reset)"
    }
}
