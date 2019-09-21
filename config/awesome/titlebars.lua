local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local button_char = ""

local function create_text_button(c, char, color_normal, color_focused)
    local btn = wibox.widget.textbox()
    btn.font = "Typicons 16"
    btn.markup = helpers.colorize_text(char, color_normal)
    btn.forced_width = dpi(20)

    c:connect_signal("focus", function()
        btn.markup = helpers.colorize_text(char, color_focused)
    end)
    c:connect_signal("unfocus", function()
        btn.markup = helpers.colorize_text(char, color_normal)
    end)

    return btn
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    -- Minimize, maximize and close buttons
    local btn_close = create_text_button(c, button_char, beautiful.xcolor8, beautiful.xcolor1)
    btn_close:buttons(
        gears.table.join(
            awful.button({ }, 1, function()
                c:kill()
            end)
        )
  	)
    local btn_maximize = create_text_button(c, button_char, beautiful.xcolor8, beautiful.xcolor3)
    btn_maximize:buttons(
        gears.table.join(
            awful.button({ }, 1, function()
                c.maximized = not c.maximized
            end)
        )
  	)
    local btn_minimize = create_text_button(c, button_char, beautiful.xcolor8, beautiful.xcolor2)
    btn_minimize:buttons(
        gears.table.join(
            awful.button({ }, 1, function()
                -- cl.minimized = true not works. WTF?
                awful.key.execute({ modkey,}, "n")
            end)
        )
  	)

    awful.titlebar(c, {size = beautiful.titlebar_size}):setup {
        nil,
        { -- Middle
            -- { -- Title
            --     align  = "center",
            --     widget = awful.titlebar.widget.titlewidget(c)
            -- },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            btn_minimize,
            btn_maximize,
            btn_close,
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
