-- -------------------------
-- System & GUI Applications
-- -------------------------
local browser = "uwsm app -- zen-browser"
-- local browser = "uwsm app -- helium-browser"
local lock = "uwsm app -- hyprlock"
local menu = "uwsm app -- tofi-drun --drun-launch=true"

-- -------------------------
-- Terminal Definitions
-- -------------------------
local terminal = "uwsm app -- ghostty"
local terminal_floating = terminal .. " --font-size=12"

-- -------------------------
-- TUIs
-- -------------------------
local about = terminal .. " --class=about.com.mitchellh.ghostty"
local anime = terminal .. " --class=anime.com.mitchellh.ghostty -e ani-cli -q 1080p --dub"
local music = terminal .. " --class=rmpc.com.mitchellh.ghostty -e rmpc"

-- -------------------------
-- Floating TUIs
-- -------------------------
local fileManager = terminal .. " --class=joshuto.com.mitchellh.ghostty -e joshuto"
local opencode = terminal_floating .. " --class=opencode.floating.com.mitchellh.ghostty -e opencode"
local paru = terminal_floating .. " --class=paru.com.mitchellh.ghostty -e pi"
local btop = terminal_floating .. " --class=btop.com.mitchellh.ghostty -e btop"

-- Export for use in other modules
return {
	browser = browser,
	lock = lock,
	menu = menu,
	terminal = terminal,
	terminal_floating = terminal_floating,
	about = about,
	anime = anime,
	music = music,
	fileManager = fileManager,
	opencode = opencode,
	paru = paru,
	btop = btop,
}
