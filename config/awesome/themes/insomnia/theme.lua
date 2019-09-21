local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local helpers = require("helpers")

local theme_path = "~/.config/awesome/themes/insomnia"
local icons_path = "~/.config/awesome/icons"
local weather_icons = "~/.config/awesome/weather"

local theme = {}

-- Get colors from .Xresources and set fallback colors
theme.xbackground = xrdb.background or "#21252b"
theme.xforeground = xrdb.foreground or "#9da5b4"
theme.xcolor0     = xrdb.color0     or "#454A54"
theme.xcolor1     = xrdb.color1     or "#D7424F"
theme.xcolor2     = xrdb.color2     or "#98c379"
theme.xcolor3     = xrdb.color3     or "#e5c07b"
theme.xcolor4     = xrdb.color4     or "#61afef"
theme.xcolor5     = xrdb.color5     or "#c678dd"
theme.xcolor6     = xrdb.color6     or "#56b6c2"
theme.xcolor7     = xrdb.color7     or "#CDCDCD"
theme.xcolor8     = xrdb.color8     or "#5C6370"
theme.xcolor9     = xrdb.color9     or "#e06c75"
theme.xcolor10    = xrdb.color10    or "#B3D39C"
theme.xcolor11    = xrdb.color11    or "#E9CB93"
theme.xcolor12    = xrdb.color12    or "#8FC6F4"
theme.xcolor13    = xrdb.color13    or "#D7A1E7"
theme.xcolor14    = xrdb.color14    or "#7BC6D0"
theme.xcolor15    = xrdb.color15    or "#E6E6E6"

theme.font          = "Ubuntu Medium 9"

theme.bg_normal     = theme.xbackground
theme.bg_focus      = theme.xbackground
theme.bg_urgent     = theme.xbackground
-- bg_minimize also applied as foreground color for hotkeys popup
theme.bg_minimize   = theme.xcolor0
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.xforeground
theme.fg_focus      = theme.xforeground
theme.fg_urgent     = theme.xforeground
theme.fg_minimize   = theme.xforeground

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(0)
theme.border_normal = theme.xbackground
theme.border_focus  = theme.xbackground
theme.border_marked = theme.xbackground

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.exit_screen_bg = theme.xbackground.."AF"
theme.exit_screen_fg = theme.xforeground
theme.lock_screen_bg = theme.xbackground.."E1"
theme.lock_screen_fg = theme.xforeground
theme.wibar_fg = theme.xcolor8
theme.tasklist_bg_minimize = theme.bg_normal
theme.tasklist_fg_normal = theme.xcolor8
theme.tasklist_fg_focus = theme.xforeground
theme.tasklist_align = "center"

-- Sidebar bars
theme.volume_bar_active_color = theme.xcolor6
theme.volume_bar_muted_color = "#666666"
theme.battery_bar_active_color = theme.xcolor5
theme.ram_bar_active_color = theme.xcolor4
theme.sysload_bar_active_color = theme.xcolor2
theme.temperature_bar_active_color = theme.xcolor1
theme.brightness_bar_active_color = theme.xcolor3
theme.bars_background = theme.xcolor0

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_border_radius = dpi(6)
theme.notification_shape = helpers.rrect(theme.notification_border_radius)
theme.notification_padding = 5
theme.notification_spacing = 5
theme.notification_margin = dpi(10)
theme.notification_bg_critical = theme.bg_normal
theme.notification_fg_critical = theme.xcolor1
theme.notification_icon_size = 34

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."/submenu.png"
theme.menu_height = dpi(18)
theme.menu_width  = dpi(120)

-- Candy taglist
theme.taglist_text_font = "Typicons 11"
theme.taglist_text_empty    = {"","","","","","","","","",""}
theme.taglist_text_occupied = {"","","","","","","","","",""}
theme.taglist_text_focused  = {"","","","","","","","","",""}
theme.taglist_text_urgent   = {"","","","","","","","","",""}
-- theme.taglist_text_urgent   = {"","","","","","","","","",""}
-- theme.taglist_text_urgent   = {"","","","","","","","","",""}
theme.taglist_text_color_empty    = { theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8, theme.xcolor8 }
theme.taglist_text_color_occupied  = { theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4, theme.xcolor5, theme.xcolor6, theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4 }
theme.taglist_text_color_focused  = { theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4, theme.xcolor5, theme.xcolor6, theme.xcolor1, theme.xcolor2, theme.xcolor3, theme.xcolor4 }
theme.taglist_text_color_urgent   = { theme.xcolor9, theme.xcolor10, theme.xcolor11, theme.xcolor12, theme.xcolor13, theme.xcolor14, theme.xcolor9, theme.xcolor10, theme.xcolor11, theme.xcolor12 }

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
theme.maximized_hide_border = true
theme.tasklist_disable_icon = true
theme.titlebar_size = 26
theme.wibar_height = 24
theme.border_radius = dpi(6)

-- Icons
theme.icon_brightness = icons_path.."/brightness.png"
theme.icon_exit = icons_path.."/exit.png"
theme.icon_lock = icons_path.."/lock.png"
theme.icon_poweroff = icons_path.."/poweroff.png"
theme.icon_reboot = icons_path.."/reboot.png"
theme.icon_volume = icons_path.."/volume.png"
theme.icon_muted = icons_path.."/muted.png"
theme.icon_battery = icons_path.."/battery.png"
theme.icon_battery_charging = icons_path.."/battery_charging.png"
theme.icon_ram = icons_path.."/ram.png"
theme.icon_temperature = icons_path.."/temperature.png"
theme.icon_sysload = icons_path.."/sysload.png"
theme.icon_terminal = icons_path.."/terminal.png"
theme.icon_suspend = icons_path.."/suspend.png"
theme.icon_redshift = icons_path.."/redshift.png"
theme.icon_music = icons_path.."/music.png"
-- Playerctl icons
theme.playerctl_toggle = icons_path.."/playerctl_toggle.png"
theme.playerctl_next = icons_path.."/playerctl_next.png"
theme.playerctl_prev = icons_path.."/playerctl_prev.png"

-- Wallpaper
theme.wallpaper = theme_path.."/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_path.."/layouts/fairhw.png"
theme.layout_fairv = theme_path.."/layouts/fairvw.png"
theme.layout_floating  = theme_path.."/layouts/floatingw.png"
theme.layout_magnifier = theme_path.."/layouts/magnifierw.png"
theme.layout_max = theme_path.."/layouts/maxw.png"
theme.layout_fullscreen = theme_path.."/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_path.."/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_path.."/layouts/tileleftw.png"
theme.layout_tile = theme_path.."/layouts/tilew.png"
theme.layout_tiletop = theme_path.."/layouts/tiletopw.png"
theme.layout_spiral  = theme_path.."/layouts/spiralw.png"
theme.layout_dwindle = theme_path.."/layouts/dwindlew.png"
theme.layout_cornernw = theme_path.."/layouts/cornernww.png"
theme.layout_cornerne = theme_path.."/layouts/cornernew.png"
theme.layout_cornersw = theme_path.."/layouts/cornersww.png"
theme.layout_cornerse = theme_path.."/layouts/cornersew.png"

-- systray
-- theme.systray_icon_spacing = 4

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
