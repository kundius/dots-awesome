local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local btn_icon_size = 100

exit_screen = wibox({visible = false, ontop = true, type = "splash"})
awful.placement.maximize(exit_screen)

exit_screen.bg = beautiful.exit_screen_bg or "#21252b"
exit_screen.fg = beautiful.exit_screen_fg or "#E5E5E5"

function create_exit_screen_btn(icon, title, click_callback)
    local btn = wibox.widget {
        {
            image = icon,
            resize = true,
            forced_width = btn_icon_size,
            forced_height = btn_icon_size,
            widget = wibox.widget.imagebox
        },
        {
            text = title,
            align = "center",
            font = "sans 12",
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.vertical
    }

    btn:buttons(gears.table.join(
        awful.button({}, 1, click_callback)
    ))

    return btn
end

function exit_screen_show()
    exit_screen.visible = true
end

local lock_btn = create_exit_screen_btn(beautiful.icon_lock, "Lock", function()
    exit_screen.visible = false
    lock_screen_show()
end)
local reboot_btn = create_exit_screen_btn(beautiful.icon_reboot, "Reboot", function()
    awful.spawn.with_shell("reboot")
end)
local poweroff_btn = create_exit_screen_btn(beautiful.icon_poweroff, "Poweroff", function()
    awful.spawn.with_shell("poweroff")
end)
local suspend_btn = create_exit_screen_btn(beautiful.icon_suspend, "Suspend", function()
    exit_screen.visible = false
    lock_screen_show()
    awful.spawn.with_shell("systemctl suspend")
end)

exit_screen:setup {
    nil,
    {
        nil,
        {
            lock_btn,
            reboot_btn,
            poweroff_btn,
            suspend_btn,
            spacing = 20,
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.vertical,
        expand = "none"
    },
    layout = wibox.layout.align.horizontal,
    expand = "none"
}

exit_screen:buttons(gears.table.join(
    awful.button({}, 3, function()
        exit_screen.visible = false
    end)
))
