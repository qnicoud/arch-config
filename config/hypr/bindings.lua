-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local fileManager = "kitty spf"
local fileManager = "nautilus"
local menu = "wofi --show drun"
local menu = "rofi -show drun"

-- Base bindigs hyprland
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("systemctl hibernate"))

-- Start programs
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/rofi/scripts/rofi-wrapper.sh games"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/doom_run.sh"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty nvim"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("proton-mail"))

-- Utility scripts and sub-menus
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/colorpick.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/startWaybar.sh"))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper.sh"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("~/.config/rofi/scripts/emoji-picker.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("~/.config/rofi/scripts/icon-picker.sh"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.config/rofi/scripts/sddm.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/wbswitcher.sh"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("~/.config/rofi/scripts/menu.sh"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Get workspace overview
-- TODO: manual review on line 44 — no mapping for dispatcher "hyprexpo:expo"
-- hl.bind(mainMod .. " + SHIFT + down", hl.dsp.hyprexpo_expo("toggle"))

-- Switch to next empty workspace
hl.bind(mainMod .. " + return", hl.dsp.focus({ workspace = "empty" }))

-- Switch to next or previous workspace in list
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces with mainMod + [0-9]
-- hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = 1 }))
-- hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = 2 }))
-- hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = 3 }))
-- hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = 4 }))
-- hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = 5 }))
-- hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = 6 }))
-- hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = 7 }))
-- hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = 8 }))
-- hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = 9 }))
-- hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- hl.bind(mainMod .. " + SHIFT + ampersand", hl.dsp.window.move({ workspace = 1 }))
-- hl.bind(mainMod .. " + SHIFT + eacute", hl.dsp.window.move({ workspace = 2 }))
-- hl.bind(mainMod .. " + SHIFT + quotedbl", hl.dsp.window.move({ workspace = 3 }))
-- hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.window.move({ workspace = 4 }))
-- hl.bind(mainMod .. " + SHIFT + parenleft", hl.dsp.window.move({ workspace = 5 }))
-- hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = 6 }))
-- hl.bind(mainMod .. " + SHIFT + egrave", hl.dsp.window.move({ workspace = 7 }))
-- hl.bind(mainMod .. " + SHIFT + underscore", hl.dsp.window.move({ workspace = 8 }))
-- hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ workspace = 9 }))
-- hl.bind(mainMod .. " + SHIFT + agrave", hl.dsp.window.move({ workspace = 10 }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ 5%-"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot a window
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot a region
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- will switch to a submap called resize
hl.bind("ALT + R", hl.dsp.submap("resize"))
-- will start a submap called "resize"
hl.define_submap("resize", function()
    -- sets repeatable binds for resizing the active window
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    -- use reset to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
    -- will reset the submap, which will return to the global submap
end)

-- will swith to a submap called swap
hl.bind("ALT + S", hl.dsp.submap("swap"))
hl.define_submap("swap", function()
    hl.bind("up", hl.dsp.window.swap({ direction = "u" }), { repeating = true })
    hl.bind("down", hl.dsp.window.swap({ direction = "d" }), { repeating = true })
    hl.bind("left", hl.dsp.window.swap({ direction = "l" }), { repeating = true })
    hl.bind("right", hl.dsp.window.swap({ direction = "r" }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("gaming"))
hl.define_submap("gaming", function()
    hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("reset"))
end)
