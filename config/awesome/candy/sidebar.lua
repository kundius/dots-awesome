local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local helpers = require("helpers")

-- Set some constants
local icon_size = dpi(36)
local progress_bar_width = dpi(215)

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, icon)
    icon.forced_height = icon_size
    icon.forced_width = icon_size
    icon.resize = true
    bar.forced_width = progress_bar_width
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    local w = wibox.widget{
        nil,
        {
            icon,
            bar,
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

local function make_playerctl_button(image, onclick)
    local btn = wibox.widget.imagebox(image)
    btn.resize = true
    btn.forced_width = 44
    btn.forced_height = 44
    btn:buttons(gears.table.join(
        awful.button({}, 1, onclick)
    ))
    return btn
end

local time = wibox.widget.textclock("%R")
time.align = "center"
time.valign = "center"
time.font = "sans 55"

local date = wibox.widget.textclock("%A, %B %d")
date.align = "center"
date.valign = "center"
date.font = "sans 16"

local fancy_date = wibox.widget.textclock("%-j days around the sun")
-- local fancy_date = wibox.widget.textclock("Knowing that today is %A fills you with determination.")
fancy_date.align = "center"
fancy_date.valign = "center"
fancy_date.font = "sans 11"

-- Volume bar
local volume_icon = wibox.widget.imagebox(beautiful.icon_volume)
local volume_bar = require("candy.volume_bar")
local volume = format_progress_bar(volume_bar, volume_icon)

volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control("toggle")
    end),
    -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, function ()
        -- helpers.run_or_raise({class = 'Pavucontrol'}, true, "pavucontrol")
    end),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function ()
        helpers.volume_control("up")
    end),
    awful.button({ }, 5, function ()
        helpers.volume_control("down")
    end)
))

awesome.connect_signal("volume::update", function(vol, muted)
    if muted then
        volume_icon.image = beautiful.icon_muted
    else
        volume_icon.image = beautiful.icon_volume
    end
end)

-- Battery
local battery_icon = wibox.widget.imagebox(beautiful.icon_battery)
local battery_bar = require("candy.battery_bar")
local battery = format_progress_bar(battery_bar, battery_icon)

awesome.connect_signal("evil::charger", function(plugged)
    if plugged then
        battery_icon.image = beautiful.icon_battery_charging
    else
        battery_icon.image = beautiful.icon_battery
    end
end)

-- Ram
local ram_icon = wibox.widget.imagebox(beautiful.icon_ram)
local ram_bar = require("candy.ram_bar")
local ram = format_progress_bar(ram_bar, ram_icon)

-- Cpu temperature
local temperature_icon = wibox.widget.imagebox(beautiful.icon_temperature)
local temperature_bar = require("candy.temperature_bar")
local temperature = format_progress_bar(temperature_bar, temperature_icon)

-- Average system load
local sysload_icon = wibox.widget.imagebox(beautiful.icon_sysload)
local sysload_bar = require("candy.sysload_bar")
local sysload = format_progress_bar(sysload_bar, sysload_icon)

-- Brightness
local brightness_icon = wibox.widget.imagebox(beautiful.icon_brightness)
local brightness_bar = require("candy.brightness_bar")
local brightness = format_progress_bar(brightness_bar, brightness_icon)

local sidebar = wibox({visible = false, ontop = true, type = "dock"})

sidebar:buttons(gears.table.join(
    -- Middle click - Hide sidebar
    awful.button({ }, 2, function ()
        sidebar.visible = false
    end)
    -- Right click - Hide sidebar
    -- awful.button({ }, 3, function ()
    --     sidebar.visible = false
    --     -- mymainmenu:show()
    -- end)
))

local exit_btn = wibox.widget {
    {
        image = beautiful.icon_poweroff,
        resize = true;
        forced_width = 40,
        forced_height = 40,
        widget = wibox.widget.imagebox
    },
    {
        text = "Exit",
        widget = wibox.widget.textbox
    },
    layout = wibox.layout.fixed.horizontal
}

exit_btn:buttons(gears.table.join(
    awful.button({}, 1, function()
        hide_sidebar()
        exit_screen_show()
    end)
))

local governor_switch_text = wibox.widget.textbox("CPU Governor")
local governor_switch_icon = wibox.widget.imagebox(beautiful.icon_sysload)
governor_switch_icon.resize = true
governor_switch_icon.forced_width = 40
governor_switch_icon.forced_height = 40
local governor_switch = wibox.widget {
    nil,
    {
        governor_switch_icon,
        governor_switch_text,
        layout = wibox.layout.fixed.horizontal
    },
    expand = "none",
    layout = wibox.layout.align.horizontal
}
awesome.connect_signal("cpu::governor", function(governor)
    governor_switch_text.markup = helpers.colorize_text("CPU Governor", beautiful.xcolor0).."\n"..governor
    if governor == "performance" then
        governor_switch_icon.image = beautiful.icon_temperature
    else
        governor_switch_icon.image = beautiful.icon_sysload
    end
end)
governor_switch:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("cpu-power.sh --switch")
    end)
))
-- Initialize current governor info
awful.spawn.with_shell("cpu-power.sh --emit")

-- Night mode section
local night_mode_text = wibox.widget.textbox("Night Mode")
local night_mode_icon = wibox.widget.imagebox(beautiful.icon_redshift)
night_mode_icon.resize = true
night_mode_icon.forced_width = 40
night_mode_icon.forced_height = 40
local night_mode = wibox.widget {
    nil,
    {
        night_mode_icon,
        night_mode_text,
        layout = wibox.layout.fixed.horizontal
    },
    expand = "none",
    layout = wibox.layout.align.horizontal
}
awesome.connect_signal("system::nightmode", function(state)
    night_mode_text.markup = helpers.colorize_text("Night Mode", beautiful.xcolor0).."\n"..state
end)
night_mode:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("night-mode.sh")
    end)
))

-- MPD widget section
local playerctl_toggle = make_playerctl_button(beautiful.playerctl_toggle, function() awful.spawn.with_shell("mpc toggle") end)
local playerctl_next = make_playerctl_button(beautiful.playerctl_next, function() awful.spawn.with_shell("mpc next") end)
local playerctl_prev = make_playerctl_button(beautiful.playerctl_prev, function() awful.spawn.with_shell("mpc prev") end)
local mpd_title = wibox.widget.textbox()
local mpd_artist = wibox.widget.textbox()
mpd_title.align = "center"
mpd_title.valign = "center"
mpd_title.font = "sans 12"
mpd_artist.align = "center"
mpd_artist.valign = "center"
mpd_artist.font = "sans 10"
local mpd_song = wibox.widget {
    mpd_title,
    mpd_artist,
    layout = wibox.layout.fixed.vertical
}
mpd_song:buttons(gears.table.join(
    awful.button({}, 1, function() awful.spawn.with_shell(terminal.." -e ncmpcpp") end)
))
local mpd = wibox.widget {
    {
        nil,
        {
            playerctl_prev,
            playerctl_toggle,
            playerctl_next,
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    },
    mpd_song,
    layout = wibox.layout.fixed.vertical
}
awesome.connect_signal("evil::mpd", function(title, artist, paused)
    local color = paused and beautiful.xcolor8 or beautiful.xforeground
    mpd_title.markup = helpers.colorize_text(title, color)
    mpd_artist.markup = helpers.colorize_text(artist, color)
end)

-- Empty textbox to make a line break
local br = wibox.widget.textbox(" ")

sidebar:setup {
    { -- Top
        time,
        date,
        fancy_date,
        layout = wibox.layout.fixed.vertical
    },
    { -- Middle
        br,
        mpd,
        br,
        volume,
        battery,
        brightness,
        ram,
        sysload,
        temperature,
        br,
        {
            nil,
            {
                governor_switch,
                night_mode,
                spacing = 10,
                layout = wibox.layout.fixed.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        layout = wibox.layout.fixed.vertical
    },
    { -- Bottom
        {
            {
                nil,
                exit_btn,
                layout = wibox.layout.align.horizontal,
                expand = "none"
            },
            bottom = 20,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.align.vertical
}

-- Hide sidebar on mouseleave
sidebar:connect_signal("mouse::leave", function()
    sidebar.visible = false
end)

local function update_sidebar_geometry()
    sidebar.screen = awful.screen.focused()
    sidebar.height = beautiful.sidebar_height or awful.screen.focused().geometry.height
    sidebar.width = beautiful.sidebar_width or dpi(300)
end

function toggle_sidebar()
    if sidebar.visible then
        if sidebar.screen == awful.screen.focused() then
            sidebar.visible = false
        else
            update_sidebar_geometry()
        end
    else
        update_sidebar_geometry()
        sidebar.visible = true
    end
end

function hide_sidebar()
    sidebar.visible = false
end
