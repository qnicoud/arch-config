-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/

---------------------
--- SOURCE CONFIG ---
---------------------

require("bindings")
require("looknfeel")
require("monitors")
--Matugen colors
require("colors")

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "rose-pine-cursor")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("XDG_DATA_HOME", "/home/quentin/.local/share/")
hl.env("QT_QPA_PLATFORM", "wayland")

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("QT_QPA_PLATFORM=xcb openrgb --startminimized --server")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("bash .config/hypr/scripts/startWaybar.sh")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("steam -silent &")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("kitty", { monitor = "DP-2", workspace = "2 silent" })
    hl.exec_cmd("kitty btop", { monitor = "DP-2", workspace = "2 silent", maxsize = "80 64" })
    hl.exec_cmd("firefox", { monitor = "DP-1", workspace = "1  silent" })
end)

-------------
--- INPUT ---
-------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "altgr-intl",
        kb_model     = "",
        kb_options   = "lv3:ratl_switch",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = false,
        },
    },
})


hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Bind workspace helper to DP-1 for browser etc
hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
    default = true,
})
hl.workspace_rule({
    workspace = "2",
    monitor = "DP-2",
    default = true,
})

-- Set fullscreen properly for steam games
hl.window_rule({
    name = 'game_on_10th_workspace',
    workspace = 10,
    monitor = "DP-2",
    match = {
        class = '^steam_app_\\d+\\$'
    },
})

hl.workspace_rule({
    workspace = "10",
    no_border = true,
    no_rounding = true,
})
