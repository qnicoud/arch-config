---------------------
--- LOOK AND FEEL ---
---------------------

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

-- Matugen colors
local colors = require("colors")

------------------
--- ANIMATIONS ---
------------------

-- https://wiki.hyprland.org/Configuring/Variables/--animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "default",
    style = "slide",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 5,
    bezier = "default",
    style = "slide",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 5,
    bezier = "default",
    style = "slide",
})

-------------
--- RULES ---
-------------

-- WINDOW RULE
hl.window_rule({
    name = "urgent",
    match = {
        tag = "^(urgent)$",
    },
    border_color = { colors = { colors.error, colors.error }, angle = 45 },
})

-- LAYERRULES
hl.layer_rule({
    name = "layer-notifications",
    match = {
        namespace = "swaync-notification-window|swaync-control-center",
    },
    animation = "fade",
    blur = true,
    -- TODO: manual review — disable "ignore_alpha" has no layer_rule directive analog
})

hl.layer_rule({
    name = "layer-overlays-fade",
    match = {
        namespace = "swayosd|selection|hyprlock",
    },
    animation = "fade",
})

hl.layer_rule({
    name = "layer-hyprpicker",
    match = {
        namespace = "hyprpicker",
    },
    no_anim = true,
})

hl.layer_rule({
    name = "layer-waybar",
    match = {
        namespace = "waybar",
    },
    blur = true,
    ignore_alpha = 0.0,
})


hl.layer_rule({
    match = {
        namespace = "rofi",
    },
    animation = "slidein 800%",
    blur = true,
    ignore_alpha = 0.5,
})

----------------------
--- GENERAL CONFIG ---
----------------------

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 15,
        border_size = 2,
        col = {
            active_border = {colors = {colors.primary_container, colors.secondary_container}, angle = 45},
            inactive_border = surface,
        },
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 1,
        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        -- pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 1,  -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
    },

    -- CURSOR
    cursor = {
        hide_on_key_press = true,
        inactive_timeout = 3,
    },
})
