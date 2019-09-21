local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local icons = {
    floating = "",
    tile = "",
    fairv = ""
}

local s = awful.screen.focused()

local function get_current_layout()
    local layout = awful.layout.get(s)
    local layout_name = awful.layout.getname(layout)
    return layout_name
end

local layoutbox = wibox.widget.textbox()
layoutbox.font = "Typicons 14"
layoutbox.forced_width = 22
layoutbox.align = "center"
layoutbox.valign = "center"

local layout_tooltip = awful.tooltip {
    objects = { layoutbox },
    delay_show = 1,
    text = ""
}

local function update_widget()
    local layout = get_current_layout()
    layoutbox.text = icons[layout] or ""
    layout_tooltip.text = layout
end

layoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc(-1) end),
    awful.button({ }, 5, function () awful.layout.inc( 1) end)))

awful.tag.attached_connect_signal(s, "property::layout", function()
    update_widget()
end)

return layoutbox
