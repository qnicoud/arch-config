-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local fileManager = "kitty spf"
local fileManager = "nautilus"
local menu = "wofi --show drun"
local menu = "rofi -show drun"
local mailClient = "proton-mail"

-- Base bindigs hyprland
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit(), { description = "Quit Hyprland." })
hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close focused Window." })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split direction." })
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudo mode on focused window." })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle float on focused window." })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock user session." })
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("systemctl hibernate"), { description = "Hibernate." })

-- Start programs
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal), { description = "Launch " .. terminal .. "." })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "Launch " .. fileManager .. "." })
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu), { description = "Launch " .. menu .. "." })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"), { description = "Launch firefox." })
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/rofi/scripts/rofi-wrapper.sh games"),
    { description = "Open game launcher." })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/doom_run.sh"), { description = "Launch doom emacs." })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty nvim"), { description = "Launch nvim in kitty" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(mailClient), { description = "Launch " .. mailClient .. "." })

-- Utility scripts and sub-menus
hl.bind(mainMod .. " + CTRL + V",
    hl.dsp.exec_cmd("kitty --class clipse -e clipse", { float = true, size = { 622, 652 }, stay_focused = true }),
    { description = "Open clipse clipboard." })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/colorpick.sh"),
    { description = "Open color picker." })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/startWaybar.sh"),
    { description = "Start, restart or kill all bun one waybar." })
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper.sh"), { description = "Change wallpaper." })
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("~/.config/rofi/scripts/emoji-picker.sh"),
    { description = "Open emoji picker." })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("~/.config/rofi/scripts/icon-picker.sh"),
    { description = "Open icon picker." })
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.config/rofi/scripts/sddm.sh"),
    { description = "Open sddm theme switcher." })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/wbswitcher.sh"),
    { description = "Open waybar theme switcher." })
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("~/.config/rofi/scripts/menu.sh"), { description = "Open menu." })
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.cargo/bin/hyprbinds"), { description = "Display binds cheat sheet." })


-- AI related binds
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"),
    { description = "Clipboard speech to text with hyprwhspr." })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.exec_cmd("~/.local/bin/hyprwhspr-journal"),
    { description = "Speech to text journaling with zettel-ai and hyprwhspr." })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("zettel-ai && kitty zettel-validate"),
    { description = "Trigger journal parsing with zettel-ai and validation with zettel-validate." })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("zettel-ai-vocal"),
    { description = "Vocal interraction with zettel-ai for journaling tasks other than adding knowledge." })
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("zettel"),
    { description = "Toggle special zettel ai workspace." })


-- Switch windows
hl.bind("ALT + TAB", hl.dsp.exec_cmd("snappy-switcher next --mod alt"), { description = "Switch window." })
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("snappy-switcher next --workspace --mod super"),
    { description = "Switch window in current workspace." })
hl.bind(mainMod .. " + ALT + TAB", hl.dsp.exec_cmd("~/.config/hypr/scripts/startSnappySwitcher.sh"),
    { description = "Restart snappy-switcher." })
-- Switch windows in group
hl.bind(mainMod .. "+ CTRL + left", hl.dsp.group.prev(), { description = "Focus previous window in group." })
hl.bind(mainMod .. "+ CTRL + right", hl.dsp.group.next(), { description = "Focus next window in group." })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus window on the left." })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus window on the right." })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus window above." })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus window below" })

-- Get workspace overview
-- TODO: manual review on line 44 — no mapping for dispatcher "hyprexpo:expo"
-- hl.bind(mainMod .. " + SHIFT + down", hl.dsp.hyprexpo_expo("toggle"))

-- Switch to next empty workspace
hl.bind(mainMod .. " + return", hl.dsp.focus({ workspace = "empty" }), { description = "Open next empty workspace." })

-- Switch workspaces with mainMod + [0-9]
-- hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = 1 }), {description = "Switch to workspace 1"})
-- hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = 2 }), {description = "Switch to workspace 2"})
-- hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = 3 }), {description = "Switch to workspace 3"})
-- hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = 4 }), {description = "Switch to workspace 4"})
-- hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = 5 }), {description = "Switch to workspace 5"})
-- hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = 6 }), {description = "Switch to workspace 6"})
-- hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = 7 }), {description = "Switch to workspace 7"})
-- hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = 8 }), {description = "Switch to workspace 8"})
-- hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = 9 }), {description = "Switch to workspace 9"})
-- hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = 10 }), {description = "Switch to workspace 10"})

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- hl.bind(mainMod .. " + SHIFT + ampersand", hl.dsp.window.move({ workspace = 1 }), {description = "Switch window to workspace 1"})
-- hl.bind(mainMod .. " + SHIFT + eacute", hl.dsp.window.move({ workspace = 2 }), {description = "Switch window to workspace 2"})
-- hl.bind(mainMod .. " + SHIFT + quotedbl", hl.dsp.window.move({ workspace = 3 }), {description = "Switch window to workspace 3"})
-- hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.window.move({ workspace = 4 }), {description = "Switch window to workspace 4"})
-- hl.bind(mainMod .. " + SHIFT + parenleft", hl.dsp.window.move({ workspace = 5 }), {description = "Switch window to workspace 5"})
-- hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = 6 }), {description = "Switch window to workspace 6"})
-- hl.bind(mainMod .. " + SHIFT + egrave", hl.dsp.window.move({ workspace = 7 }), {description = "Switch window to workspace 7"})
-- hl.bind(mainMod .. " + SHIFT + underscore", hl.dsp.window.move({ workspace = 8 }), {description = "Switch window to workspace 8"})
-- hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ workspace = 9 }), {description = "Switch window to workspace 9"})
-- hl.bind(mainMod .. " + SHIFT + agrave", hl.dsp.window.move({ workspace = 10 }), {description = "Switch window to workspace 10"})

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }), { description = "Switch to workspace 1" })
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }), { description = "Switch to workspace 2" })
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }), { description = "Switch to workspace 3" })
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }), { description = "Switch to workspace 4" })
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }), { description = "Switch to workspace 5" })
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }), { description = "Switch to workspace 6" })
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }), { description = "Switch to workspace 7" })
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }), { description = "Switch to workspace 8" })
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }), { description = "Switch to workspace 9" })
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }), { description = "Switch to workspace 10" })

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }),
    { description = "Switch window to workspace 1" })
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }),
    { description = "Switch window to workspace 2" })
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }),
    { description = "Switch window to workspace 3" })
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }),
    { description = "Switch window to workspace 4" })
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }),
    { description = "Switch window to workspace 5" })
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }),
    { description = "Switch window to workspace 6" })
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }),
    { description = "Switch window to workspace 7" })
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }),
    { description = "Switch window to workspace 8" })
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }),
    { description = "Switch window to workspace 9" })
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }),
    { description = "Switch window to workspace 10" })

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Focus on special workspace." })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),
    { description = "Move focused window to special workspace." })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Focus previous non-empty workspace." })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Focus next non-empty workspace." })
-- Switch to next or previous workspace in list
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Focus previous non-empty workspace." })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Focus next non-empty workspace." })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { description = "Move window arround." })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = "Resize window." })

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
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot of a window." })
-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Screenshot of a monitor." })
-- Screenshot a region
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"), { description = "Screenshot of a region." })

-- will switch to a submap called resize
hl.bind("ALT + R", hl.dsp.submap("resize"), { description = "Enter window resize submap." })
-- will start a submap called "resize"
hl.define_submap("resize", function()
    -- sets repeatable binds for resizing the active window
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
        { repeating = true, description = "Resize from right." })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
        { repeating = true, description = "Resize from left." })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
        { repeating = true, description = "Resize from top." })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
        { repeating = true, description = "Resize from bottom." })
    -- use reset to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"), { description = "Leave window resize submap." })
    -- will reset the submap, which will return to the global submap
end)

-- will swith to a submap called swap
hl.bind("ALT + S", hl.dsp.submap("swap"), { description = "Enter window swaping submap." })
hl.define_submap("swap", function()
    hl.bind("up", hl.dsp.window.swap({ direction = "u" }), { repeating = true, description = "Swap with top window." })
    hl.bind("down", hl.dsp.window.swap({ direction = "d" }),
        { repeating = true, description = "Swap with bottom window." })
    hl.bind("left", hl.dsp.window.swap({ direction = "l" }), { repeating = true, description = "Swap with left window." })
    hl.bind("right", hl.dsp.window.swap({ direction = "r" }),
        { repeating = true, description = "Swap with righ window." })
    hl.bind("escape", hl.dsp.submap("reset"), { description = "Leave window swaping submap" })
end)

hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("gaming"), { description = "Enter gaming submap." })
hl.define_submap("gaming", function()
    hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("reset"), { description = "Leave gaming submap." })
end)
