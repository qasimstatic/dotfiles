-- Window & Layer Rules

-- -------------------------
-- Layer Rules
-- -------------------------

hl.layer_rule({
	name = "tofi_blur",
	match = { namespace = "launcher" },
	blur = true,
})

hl.layer_rule({
	name = "waybar_blur",
	match = { namespace = "waybar" },
	blur = true,
})

-- -------------------------
-- Window Rules
-- -------------------------

hl.window_rule({
	name = "opencode_float",
	match = { class = "opencode.floating.com.mitchellh.ghostty" },
	size = { 800, 500 },
	center = true,
	float = true,
	pin = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "about_float",
	match = { class = "about.com.mitchellh.ghostty" },
	size = { 800, 350 },
	float = true,
	center = true,
})

hl.window_rule({
	name = "rmpc",
	match = { class = "rmpc.com.mitchellh.ghostty" },
	fullscreen = true,
	xray = true,
})

hl.window_rule({
	name = "anime_float",
	match = { class = "anime.com.mitchellh.ghostty" },
	size = { 800, 300 },
	center = true,
	float = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "nemo_float",
	match = { class = "nemo" },
	size = { 1000, 600 },
	center = true,
	float = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "mpv_fullscreen",
	match = { class = "mpv" },
	fullscreen = true,
})

hl.window_rule({
	name = "paru_float",
	match = { class = "paru.com.mitchellh.ghostty" },
	size = { 800, 400 },
	center = true,
	float = true,
	pin = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "joshuto_float",
	match = { class = "joshuto.com.mitchellh.ghostty" },
	size = { 1000, 600 },
	center = true,
	float = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "impala_float",
	match = { class = "impala.com.mitchellh.ghostty" },
	size = { 1000, 600 },
	center = true,
	float = true,
	pin = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "wiremix_float",
	match = { class = "wiremix.com.mitchellh.ghostty" },
	size = { 1000, 600 },
	center = true,
	float = true,
	pin = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "btop_float",
	match = { class = "btop.com.mitchellh.ghostty" },
	size = { 1000, 600 },
	center = true,
	float = true,
	pin = true,
	opacity = "0.90",
})

hl.window_rule({
	name = "vesktop",
	match = { class = "vesktop" },
	opacity = "0.85",
	xray = true,
})

hl.window_rule({
	name = "zathura",
	match = { class = "org.pwmt.zathura" },
})
