# Interactive Paru Installer

try {
    paru -Qa | fzf --preview='paru -Qi {1}' --bind 'enter:execute(paru -S {1})+abort'
} catch {
    print "\n[red]✗ Installation failed.[/red]"
    print "\n[yellow]Please check the errors above and try again.[/yellow]"
    exit 1
}

if $env.LAST_EXIT_CODE == 0 {
    print "\n[green]✓ Installation successful![/green]"
    print "\n[yellow]Please exit the CLI (Ctrl+D or type 'exit')[/yellow]"
} else {
    print "\n[red]✗ Installation failed.[/red]"
    print "\n[yellow]Please check the errors above and try again.[/yellow]"
}
