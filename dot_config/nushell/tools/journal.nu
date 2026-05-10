def journal [] {
    # Heading: dd/mm/yy
    let heading_date = date now | format date '%d/%m/%y'
    
    # Filename: dd-mm-yy.md
    let filename_date = date now | format date '%d-%m-%y'
    let filename = $"($filename_date).md"

    # Create file with template if it doesn't exist
    if not ($filename | path exists) {
        $"# ($heading_date)\n\n## Topics\n\n## Code\n```cpp\n```\n" | save $filename
    }

    # Open in Neonvim (via your nvim alias)
    ^nvim $filename
}
