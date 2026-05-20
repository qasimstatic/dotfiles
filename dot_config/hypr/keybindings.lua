-- Keybindings Configuration
local apps = require("defaults")

local mainMod = "SUPER"

-- -------------------------
-- Applications
-- -------------------------
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(apps.about))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(apps.music))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(apps.opencode))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(apps.btop))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(apps.paru))

-- Voxtype Voice Dictation
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("voxtype record start"))
-- bindr = release flag in the original config
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("voxtype record stop"), { release = true })

-- -------------------------
-- System & Menus
-- -------------------------
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps.menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("tofi-cliphist"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(apps.lock))

-- Screenshots
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		"grimblast --notify copysave screen " .. os.getenv("HOME") .. "/screenshots/shot_$(date +%Y%m%d_%H%M%S).png"
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		"grimblast --notify copysave area " .. os.getenv("HOME") .. "/screenshots/shot_$(date +%Y%m%d_%H%M%S).png"
	)
)

-- -------------------------
-- Window Management
-- -------------------------
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
-- unbind = CTRL, RETURN  (commented out in original)
hl.bind("ALT + RETURN", hl.dsp.window.fullscreen_state({ internal = 2, client = 0 }))

-- Move focus with alt + vim keys
hl.bind("ALT + H", hl.dsp.focus({ direction = "l" }))
hl.bind("ALT + L", hl.dsp.focus({ direction = "r" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "u" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "d" }))

-- -------------------------
-- Workspaces
-- -------------------------
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- -------------------------
-- Mouse Bindings
-- -------------------------
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- -------------------------
-- System & Media
-- -------------------------
-- Laptop multimedia keys for volume and LCD brightness
-- bindel = repeating + locked in the original config
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
