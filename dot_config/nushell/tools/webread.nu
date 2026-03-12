def webread [url: string] {
    let clean_url = if ($url | str starts-with "http") { $url } else { $"https://($url)" }
    let jina_url = $"https://r.jina.ai/($clean_url)"

    curl -s -f -L -H $"Authorization: Bearer ($env.JINA_API_KEY)" $jina_url | glow --tui
}
