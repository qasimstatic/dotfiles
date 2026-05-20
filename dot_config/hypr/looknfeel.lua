-- Look and Feel Configuration
local mocha = require("mocha")

hl.config({
    general = {
        gaps_in     = 0,
        gaps_out    = 0,
        border_size = 2,
        col = {
            active_border   = mocha.green,
            inactive_border = mocha.mauve,
        },
        layout = "dwindle",
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Note: render.cm_fs_passthrough was removed in 0.55
-- It is now automatic with render.cm_auto_hdr

hl.config({
    decoration = {
        rounding         = 0,
        inactive_opacity = 0.80,

        blur = {
            enabled = true,
            size    = 3,
            passes  = 3,
        },
    },
})

hl.config({
    animations = {
        enabled = false,
    },
})

hl.config({
    dwindle = {
        -- Note: pseudotile was removed in 0.55 as it wasn't doing anything
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },
})
